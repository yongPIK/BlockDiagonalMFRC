# Block Diagonal MFRC code package

MATLAB code, plotting scripts and data results used for the manuscript for the following paper: 

## Title 
Modularity Enables Multi-Functional Reservoir Computing for Reconstructing Multiple Chaotic Attractors

by Kaiwen Jiang, Xingang Wang, and Yong Zou

Corresponding author: yzou@phy.ecnu.edu.cn

## Abstract:

Reservoir Computing (RC) has been shown to be an efficient paradigm for reconstructing chaotic attractors from time series. While the extension to Multi-functional Reservoir Computing (MFRC) has become a promising topic, existing methods struggle to handle attractors that are not strictly separated in phase space, severely limiting their applicability. We introduce a novel MFRC framework that overcomes this dependence on attractor separation by employing a modular block-diagonal reservoir structure. Our approach assigns different chaotic attractors into independent sub-regions of the reservoir's phase space, achieving effective spatial decoupling and precise reconstruction. This architecture deconstructs a high-dimensional dynamic system into multiple low-dimensional sub-modules, each specifically tuned to capture the dynamics of a particular attractor. Based on the natural decoupling observed in the functional network of a reservoir, we further propose incorporating network modularity into the hyperparameter optimization process. This approach enhances the multi-functional capability of the traditional reservoir computing. The successful reconstruction for attractors from both numerical models and experimental circuits demonstrates that our MFRC framework shows versatility and performance in scalability, efficiency, heterogeneous compatibility, and robustness to attractor overlap. Therefore, it provides us with a robust and scalable technical framework for multi-functional learning in complex nonlinear systems.

## Files in the zipped folder:

## Directory structure

```text
MATLAB/
  README.md         all MATLAB settings and hyper-parameters (systems, global settings,
                    reservoir hyper-parameters, entry points, KLD protocol)
  shared/           common functions (gene_Win / gene_Wr / GP / modularity / mutual information)
  MFRC_core/        ten-system MFRC experiment and success-rate statistics
  multifunctionRC/  unified entry run_MFRC, optimisation example, plotting entry, legacy scripts
  RC_single/        classical single-task RC (including the updated GP version)
  sprottBC_modularity_robustness/  Sprott B/C modularity and cross-module perturbations (Fig. 8)
  KLD_MATLAB/       KLD reconstruction success rates (Table 4)
Data/
  TimeSeries/                       12 raw time series
  result_MFRC/result_MFRC/          D2 results and attractor trajectories of the ten systems (MFRC / RC)
  KLD_MATLAB/results/               KLD results (Table 4)
  Wout_norm/data/                   readout-weight norm data (Fig. 12)
  sprottBC_modularity_robustness/   success-rate and Q grids of Fig. 8
  multifunctionRC/result_add_noise/ functional-network modularity Q grid (Fig. 8d)
  GP_updated/                       classical RC results obtained with the updated GP
Python_review/                      Python recomputation and figure code used in the reply
```

## Running

```matlab
addpath(genpath('MATLAB'));

run_MFRC('10sys')                   % Fig.7 / Table 3 (ten-system MFRC)
run_MFRC('sprottbc_addnoise')       % Fig.8(a-c)
run_MFRC('sprottbc_muinfo')         % Fig.8(d)

plot_MFRC_figures('main')           % attractors and D2 distributions
plot_MFRC_figures('wout')           % Fig.12

cd('MATLAB/KLD_MATLAB'); run_KLD_success_10sys   % Table 4
```

```bash
cd Python_review
pip install -r requirements.txt
python run_R1_11_R1_12_figures.py   # generates the reply figure Fig.R1 (W_r sparsity)
python run_R1_13_readout.py         # generates the reply figure Fig.R2 (readout weights)
```

The MATLAB scripts read the time series shipped in `Data/TimeSeries`; the
Python scripts read `Python_review/raw_data`.
