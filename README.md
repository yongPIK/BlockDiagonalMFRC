# BlockDiagonalMFRC
We introduce a novel MFRC framework that overcomes this dependence on attractor separation by employing a modular block-diagonal reservoir structure. Our approach orthogonally projects different chaotic attractors into independent sub-regions of the reservoir's phase space, achieving effective spatial decoupling and precise reconstruction.

A Simple Yet Effective Approach to Multi-Functional Reservoir Computing for Chaotic Time-Series Prediction

by J. K. Jiang, X. G. Wang, and Y. Zou

Dataset Parameters for Ten Chaotic Systems
System Name	Data File	Input Dimension	Output Dimension	Reservoir Size
SprottA	data_SprottA_2000_0.01.dat	3	3	100
SprottB	data_SprottB_2000_0.01.dat	3	3	100
SprottC	data_SprottC_2000_0.01.dat	3	3	100
SprottD	data_SprottD_2000_0.01.dat	3	3	100
Lorenz	data_Lorenz.dat	3	3	100
Roessler	data_roessler2_1000_0.01.dat	3	3	100
Chen	data_chen_1000_0.01.dat	3	3	100
Sel'kov	data_sel_kov_1000_0.01.dat	2	2	100
Hyperchaotic Oscillator	data_hyperchaotic_oscillator_1000_0.01.dat	4	4	500
Hyper SprottB	data_hyper_sprottB_1000_0.01.dat	5	5	500




Function Descriptions

gene_Win(resSize, inSize, add_dim, W_in_a, W_in_type)	
Generates input weight matrix:
- resSize: Reservoir size
- inSize: Input dimension
- add_dim: Whether to add extra dimension (0/1)
- W_in_a: Input weight magnitude
- W_in_type: Weight type (1: uniform distribution, 2: normal distribution)

gene_Wr(resSize, k, eig_rho, W_r_type)	
Generates internal reservoir weight matrix:
- resSize: Reservoir size
- k: Average degree (sparsity)
- eig_rho: Desired spectral radius
- W_r_type: Weight type (1: uniform distribution, 2: normal distribution)

Grassberger_Procaccia(dim, data)	Calculates correlation dimension:
- dim: Embedding dimension
- data: Input data matrix (rows: time points, columns: dimensions)
