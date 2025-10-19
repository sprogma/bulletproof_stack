Start-Job -ScriptBlock {
    $code = gc "./optimizer/visual.cs" -Raw
    $refs = @(
        "System.Windows.Forms",
        "System.Drawing.Common",
        "System.Runtime",
        "System.Text.Json",
        "System.Collections",
        "System.Numerics.Vectors",
        "System.Linq",
        "System.ComponentModel.Primitives",
        "System.Windows.Forms.Primitives",
        "System.Drawing.Primitives"
    )
    Add-Type -TypeDefinition $code -ReferencedAssemblies $refs
    [SimpleGraphForm]::RunForm("./res.prof")
} | Wait-Job | Receive-Job
