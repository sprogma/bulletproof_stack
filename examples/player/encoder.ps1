param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile,
    [Parameter(Mandatory=$true)]
    [int]$Treshold,
    [int]$W=160,
    [int]$H=90
)
ffmpeg -y -i $InputFile -vf "[in]scale=iw*min($($W)/iw\,$($H)/ih):ih*min($($W)/iw\,$($H)/ih)[scaled]; [scaled]pad=$($W):$($H):($($W)-iw*min($($W)/iw\,$($H)/ih))/2:($($H)-ih*min($($W)/iw\,$($H)/ih))/2[padded]; [padded]setsar=1:1[out]" -c:v libx264 -c:a copy "shrink.mp4"
ffmpeg -i shrink.mp4 -f rawvideo -pix_fmt rgb24 output.rgb
# convert data into bytemask
Add-Type -TypeDefinition (gc -Raw converter.cs) # -ErrorAction SilentlyContinue
[RgbToBitmask]::InputBytesPerPixel = 3
[RgbToBitmask]::Treshold = $Treshold
[RgbToBitmask]::Width = $W
[RgbToBitmask]::Height = $H
[RgbToBitmask]::Convert("output.rgb", "output.bitmask")
rm shrink.mp4
rm output.rgb

# .\spu.exe -mem (256MB) -image 0x4000 a.bc -image 0x40000 .\examples\player\output.bitmask -entry 0x4000 -map "1:video10 2:timer"
