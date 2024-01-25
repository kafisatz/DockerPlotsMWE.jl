export sm

function sm(a,b)
    return py"py_sm"(a,b)
end

export main
function main()
    #PyCall test
    @assert sm(23,99) == 122
    @assert sm(23,0.4) < 23.45
    @assert sm(23,0.4) > 23.35

    #directory and files
    #the next line is also used in the LiveServer startup command
    #tmpdir_root = Sys.iswindows() ? "C:\\temp" : "/tmp"; 
    tmpdir_root = mktempdir()
    srv_fldr = joinpath(tmpdir_root, "plot"); 
    mkpath(srv_fldr);

    tmppdf = joinpath(srv_fldr, "plot.pdf")
    tmppng = joinpath(srv_fldr, "plot.png")
    
    #remove old files
    isfile(tmppng) && rm(tmppng)
    isfile(tmppdf) && rm(tmppdf)

    cnt_up = 10
    cnt_down = 1

    #@show Plots.backend()
    #using Plots
    p = Plots.pie(["up", "down"], [cnt_up, cnt_down],dpi=900)
    #and one answer to annotating the plot is:
    annotate!([-0.25, 0.25], [-0.25, 0.25], ["$(cnt_up) up", ("$(cnt_down) down", :red, :center)])

    dt = Dates.now()
    #annotate time
    Plots.title!("$(Dates.format(dt, "d U yyyy HH:MM:SS"))")

    #save
    Plots.savefig(p, tmppdf)
    Plots.savefig(p, tmppng)

    @info("Plot created. $(Dates.now())\r\n$(tmppng)")

    @info("checking filesize....")
    @show sz_pdf = filesize(tmppdf)
    @show sz_png = filesize(tmppng)
    @assert sz_pdf > 200
    @assert sz_png > 1000

    @info("Success. File sizes exceed minimums.")

    return p, tmppng, tmppdf
end
