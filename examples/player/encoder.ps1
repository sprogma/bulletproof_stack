param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile,
    [Parameter(Mandatory=$true)]
    [int]$Treshold
)
ffmpeg -y -i $InputFile -vf "[in]scale=iw*min(160/iw\,90/ih):ih*min(160/iw\,90/ih)[scaled]; [scaled]pad=160:90:(160-iw*min(160/iw\,90/ih))/2:(90-ih*min(160/iw\,90/ih))/2[padded]; [padded]setsar=1:1[out]" -c:v libx264 -c:a copy "shrink.mp4"
ffmpeg -i shrink.mp4 -f rawvideo -pix_fmt rgb24 output.rgb
# convert data into bytemask
Add-Type -TypeDefinition (gc -Raw converter.cs) # -ErrorAction SilentlyContinue
[RgbToBitmask]::InputBytesPerPixel = 3
[RgbToBitmask]::Treshold = $Treshold
[RgbToBitmask]::Convert("output.rgb", "output.bitmask")
rm shrink.mp4
rm output.rgb

# .\spu.exe -mem (256MB) -image 0x4000 a.bc -image 0x40000 .\examples\player\output.bitmask -entry 0x4000 -map "1:video10"
