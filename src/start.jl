using Pkg
Pkg.activate(".")
#Pkg.status()
Pkg.instantiate()

using DockerPlotsMWE
using Dates

#deactivate display #https://discourse.julialang.org/t/deactivate-plot-display-to-avoid-need-for-x-server/19359/13 #https://discourse.julialang.org/t/plots-jl-in-a-docker-container/109254/2
ENV["GKSwstype"]="nul"

main()