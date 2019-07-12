using Pkg
Pkg.activate(".")
Pkg.instantiate()
Pkg.status()

using Literate

# Directory where the presentations in Literate.jl format are
presentations_DIR = abspath(joinpath(@__DIR__, "presentations"))
# Directory for generated stuff
generated_DIR = abspath(joinpath(@__DIR__, "generated"))
# subdirectory for the generated presentations
generated_presentations_DIR = abspath(joinpath(generated_DIR, "presentations"))
# Erase previous generated presentations if they exist
isdir(generated_presentations_DIR) && rm(generated_presentations_DIR, recursive=true, force=true)
# Create generated if it did not exist
isdir(generated_DIR) || mkdir(generated_DIR)
# Create generated if it did not exist
isdir(generated_presentations_DIR) || mkdir(generated_presentations_DIR)

println("Generating presentations using Literate.jl")
for presentation in readdir(presentations_DIR)
    println("$presentation")
    input = joinpath(presentations_DIR, presentation)
    # Alternate the commented line to avoid executing the notebook
    # when you are editing the text only
    #Literate.notebook(input, output_DIR, execute = true)
    Literate.notebook(input, generated_presentations_DIR, execute = false)
end

