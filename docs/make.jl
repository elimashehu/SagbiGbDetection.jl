using Documenter
using SagbiGbDetection
push!(LOAD_PATH,"../src/")
makedocs(sitename="SagbiGbDetection.jl",
         pages = [
            "Home" => "index.md", "SagbiGBDetection_examples.md",
         ],
         format = Documenter.HTML(prettyurls = false)
)  


deploydocs(
    repo="github.com/elimashehu/SagbiGbDetection.jl.git",
    devbranch="main"
)

