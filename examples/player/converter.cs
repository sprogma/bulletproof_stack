using System;
using System.IO;
using System.Text;

public static class PcmToCompressed
{
    public static int StoreOnePer = 10;
    public static int BytesPerSample = 2;
    public static int InputBufferSize => StoreOnePer * BytesPerSample;

    public static void ConvertAudio(string inputPath, string outputPath)
    {
        if (!File.Exists(inputPath))
        {
            throw new ArgumentException($"Input file not found: {inputPath}");
        }
        long inSize = new FileInfo(inputPath).Length;
        if (inSize > 4294967296) // 4GB
        {
            throw new ArgumentException($"Input file size is greater than 4GB");
        }

        long nSamples = 0;

        using (var inStream = new FileStream(inputPath, FileMode.Open, FileAccess.Read, FileShare.Read))
        using (var outStream = new FileStream(outputPath, FileMode.Create, FileAccess.Write, FileShare.None))
        {
            byte[] buffer = new byte[InputBufferSize];

            while (true)
            {
                /* read group of samples */
                int readSize = 0;
                while (readSize < InputBufferSize)
                {
                    int r = inStream.Read(buffer, readSize, InputBufferSize - readSize);
                    readSize += r;
                    if (r == 0)
                    {
                        break;
                    }
                }
                if (readSize != InputBufferSize)
                {
                    break;
                }
                nSamples++;
                outStream.Write(buffer, 0, BytesPerSample);
            }
        }

        Console.WriteLine($"Conversion complete. Samples generated: {nSamples}, File written: {outputPath}");
    }
}


public static class RgbToBitmask
{
    public static int Width = 160;
    public static int Height = 90;
    public static int InputBytesPerPixel = 3;
    public static int Treshold = 255;
    public static int FrameSize => Width * Height * InputBytesPerPixel;
    public static int BytesPerLineUnpacked => Width * InputBytesPerPixel;
    public static int BytesPerLinePacked => Width / 8;

    public static bool IsSet(int r, int g, int b)
    {
        double ir = 0.299 * r;
        double ig = 0.587 * g;
        double ib = 0.114 * b;
        return r + g + b > Treshold;
    }

    public static void ConvertVideo(string inputPath, string outputPath)
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
                    if (IsSet(r, g, b))
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
