module DockerPlotsMWE

    using PyCall
    using Plots
    using Dates

    include("python.jl")
    include("main.jl")
    
end