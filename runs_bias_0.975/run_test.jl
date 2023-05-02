include("covid_model/main_util.jl")
include("covid_model/cov_graph.jl")
include("analysis_cg.jl")

using Random


function setup_logs(dir)
    file = open("$dir/data.tsv", "w")

    print_header(file, Data)

    file
end

function run(args, log_file = nothing, ovr = nothing)
    (pars,), args = load_parameters(args, (AllParams,), override=ovr)

    Random.seed!(pars.seed)

    model = setup_model(pars)

    data = observe(Data, model.world, pars)

    for i in 1:pars.n_steps
        step!(model, pars)
    end
    
    data = observe(Data, model.world, pars)
    #ticker(model, i, data)
    if log_file != nothing
        log_results(log_file, data)
    end

    data
end


const p_mut_scan = [10^-8 * 10^(i/5) for i in 0:34]
const p_inf_scan = 0:0.0005:0.01
const seeds = 1:30

for m in p_mut_scan, i in p_inf_scan
    Threads.@threads for d in seeds
        dir = "x_$(m)_$(i)_$d"
        mkdir(dir)
        ov_args = Dict(:n_steps => 3000,
                :t_repr_cycle => 1,
                :p_rec => 0.1,
                :ief_mut_mu => 0.975,
                
                :p_inf_base => i,
                :ief_p_mut => m,
                :seed => d)

        file = setup_logs(dir)
        run(["-P", "$dir/pars.run.yaml"], file, ov_args)
        close(file)

        println(dir, " done")
    end
end
