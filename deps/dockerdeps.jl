#@info("installing pip packages...")
#@info("done.")
@info("Building DockerPlotsMWE...")

using Pkg 
#Pkg.build("PyCall")

Pkg.activate("/usr/local/DockerPlotsMWE.jl")
Pkg.instantiate()
Pkg.status()

Pkg.build("DockerPlotsMWE")

@info("Finished building DockerPlotsMWE.")

#=
    import PyCall    
=#