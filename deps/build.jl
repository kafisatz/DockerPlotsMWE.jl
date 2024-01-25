@info("Building DockerPlotsMWE...")
import Pkg 

Pkg.status()
################################################################################################################################################################
#build PyCall
################################################################################################################################################################
@info("Building PyCall...")
ENV["PYCALL_DEBUG_BUILD"] ="yes"
pythonexe = Sys.iswindows() ? "python.exe" : filter(isfile,["/usr/bin/python3","/usr/local/bin/python3"])[1]
@assert isfile(pythonexe)
ENV["PYTHON"] = pythonexe
Pkg.build("PyCall")
################################################################################################################################################################
