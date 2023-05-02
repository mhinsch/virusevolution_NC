Model source code and scenario files. This version of the model corresponds to https://github.com/mhinsch/covol/releases/tag/reply_zhangetal_NC in the main repository.

## Contents

* `covid_model` - model source code
* `runs_bias_0.975` - runs with mu=0.975
* `runs_no_bias` - runs with mu=1.0


## Requirements

* A reasonably recent version of Julia (>1.5)
* Packages:
    * ArgParse
    * CompositeStructs
    * Distributions
    * EnumX
    * Erdos
    * MiniObserve (https://github.com/mhinsch/MiniObserve.jl)
    * Parameters
    * Raylib (only needed for main_gui_cg.jl)
    * SimpleGraph
    * YAML

## Model

To see available options run as

```Bash
julia main_cg.jl --help
```

or, for the GUI version

```Bash
julia main_gui_cg.jl --help
```

## Scenarios

### Contents

* `run_test.jl` - runs the scenario
* `gen_data.sh` - generate data file from scenario results
* `analysis_cg.jl` - scenario-specific analysis file
* `data_*` - generated data files as corresponding to the submitted mansuscript
* `cg test runs.ipynb` - jupyter notebook used to generate graphs from the data


### Running the scenarios

Caution, this will run several thousand simulation runs and produce a few hundred MB of output.

In order to run one of the scenarios, copy or link *the entire* source directory (i.e. `covid_model`) into the corresponding scenario directory. Then run `julia run_test.jl` in the scenario directory. Every single run will produce a directory named `x_` followed by the parameter values separated by _. Use `gen_data.sh` to collect the ouput of the last step of all runs in one tsv file.







