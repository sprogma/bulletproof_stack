param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile,
    [Parameter(Mandatory=$true)]
    [int]$Treshold,
    [int]$W=160,
    [int]$H=90
)
ffmpeg -i $InputFile audio.wav
ffmpeg -i audio.wav -vn -f s32le -acodec pcm_s32le -ar 44100 -ac 1 output.pcm
ffmpeg -y -i $InputFile -vf "[in]scale=iw*min($($W)/iw\,$($H)/ih):ih*min($($W)/iw\,$($H)/ih)[scaled]; [scaled]pad=$($W):$($H):($($W)-iw*min($($W)/iw\,$($H)/ih))/2:($($H)-ih*min($($W)/iw\,$($H)/ih))/2[padded]; [padded]setsar=1:1[out]" -c:v libx264 -c:a copy "shrink.mp4"
ffmpeg -i shrink.mp4 -f rawvideo -pix_fmt rgb24 output.rgb
# convert data into bytemask
Add-Type -TypeDefinition (gc -Raw converter.cs) # -ErrorAction SilentlyContinue
[RgbToBitmask]::InputBytesPerPixel = 3
[RgbToBitmask]::Treshold = $Treshold
[RgbToBitmask]::Width = $W
[RgbToBitmask]::Height = $H
[RgbToBitmask]::ConvertVideo("output.rgb", "output.bitmask")
[PcmToCompressed]::StoreOnePer = 5
[PcmToCompressed]::BytesPerSample = 4
[PcmToCompressed]::ConvertAudio("output.pcm", "output.audio")
rm shrink.mp4
rm output.rgb
rm audio.wav
rm output.pcm

# old version [no audio]
# .\spu.exe -mem (256MB) -image 0x4000 a.bc -image 0x40000 .\examples\player\output.bitmask -entry 0x4000 -map "1:video10 2:timer"
# new version [with audio]
# .\spu.exe -mem (256MB) -image 0x4000 a.bc -image 0x1080000 .\examples\player\output.audio -image 0x80000 .\examples\player\output.bitmask -entry 0x4000 -map "1:video5 2:timer 3:audio"


# parameters for files:
# rick.avi: 100
# text.mov: 80
# input.mp4: 30
# input2.mp4: 30
# input3.mp4: 80-85
