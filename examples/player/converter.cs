using System;
using System.IO;
using System.Text;

public static class RgbToBitmask
{
    public const int Width = 160;
    public const int Height = 90;
    public const int InputBytesPerPixel = 3;
    public const int FrameSize = Width * Height * InputBytesPerPixel;
    public const int BytesPerLineUnpacked = Width * InputBytesPerPixel;
    public const int BytesPerLinePacked = Width / 8;

    public static void Convert(string inputPath, string outputPath)
    {
        if (!File.Exists(inputPath))
        {
            throw new ArgumentException($"Input file not found: {inputPath}");
        }
        
        long inSize = new FileInfo(inputPath).Length;
        if (inSize % FrameSize != 0)
        {
            throw new ArgumentException($"Frame size {FrameSize} isn't divisible of {inSize}");
        }
        if (inSize > 4294967296) // 4GB
        {
            throw new ArgumentException($"Input file size is greater than 4GB");
        }
        
        long nFrames = (int)inSize / FrameSize;

        using (var inStream = new FileStream(inputPath, FileMode.Open, FileAccess.Read, FileShare.Read))
        using (var outStream = new FileStream(outputPath, FileMode.Create, FileAccess.Write, FileShare.None))
        {
            byte[] unpackedBuffer = new byte[BytesPerLineUnpacked];
            byte[] packedBuffer = new byte[BytesPerLinePacked];

            for (int frame = 0; frame < nFrames * Height; frame++)
            {
                /* convert each line */
                int readSize = 0;
                while (readSize < BytesPerLineUnpacked)
                {
                    int r = inStream.Read(unpackedBuffer, readSize, BytesPerLineUnpacked - readSize);
                    readSize += r;
                    if (r == 0)
                    {
                        throw new Exception($"File stream returned 0 before all data was read");
                    }
                }
                Array.Clear(packedBuffer, 0, packedBuffer.Length);
                for (int x = 0; x < Width; ++x)
                {
                    int r = unpackedBuffer[x * InputBytesPerPixel + 0];
                    int g = unpackedBuffer[x * InputBytesPerPixel + 1];
                    int b = unpackedBuffer[x * InputBytesPerPixel + 2];
                    if (r + g + b > 255)
                    {
                        packedBuffer[x / 8] |= (byte)(1 << (x % 8));
                    }
                }

                outStream.Write(packedBuffer, 0, BytesPerLinePacked);
            }
        }

        Console.WriteLine($"Conversion complete. Frames processed: {nFrames}, File written: {outputPath}");
    }
}
