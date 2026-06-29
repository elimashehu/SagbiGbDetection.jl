using Documenter
using SagbiGbDetection

const CI = get(ENV, "CI", "false") == "true"

makedocs(
    sitename = "SagbiGbDetection.jl",
    pages = [
        "Home" => "index.md",
        "Examples" => "SagbiGBDetection_examples.md",
        "Applications" => "applications.md",
    ],
    remotes = nothing,
    format = Documenter.HTML(
        prettyurls = CI,
        edit_link = nothing,
        repolink = "https://github.com/elimashehu/SagbiGbDetection.jl",
    ),
)

deploydocs(
    repo = "github.com/elimashehu/SagbiGbDetection.jl.git",
    devbranch = "main",
)
