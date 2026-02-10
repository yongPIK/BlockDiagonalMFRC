# BlockDiagonalMFRC
We introduce a novel MFRC framework that overcomes this dependence on attractor separation by employing a modular block-diagonal reservoir structure. Our approach orthogonally projects different chaotic attractors into independent sub-regions of the reservoir's phase space, achieving effective spatial decoupling and precise reconstruction.

A Simple Yet Effective Approach to Multi-Functional Reservoir Computing for Chaotic Time-Series Prediction

by J. K. Jiang, X. G. Wang, and Y. Zou

1. Dataset Parameters for Ten Chaotic Systems

| System Name | Data File | Input Dimension | Output Dimension |  Reservoir Size |
| :--- | :--- | :--- | :--- | :--- |
| Sprott A	| data_SprottA_2000_0.01.dat |  3  |  3 |  100 |
| Sprott B	| data_SprottB_2000_0.01.dat |  3  |  3 |  100 |
| Sprott C	| data_SprottC_2000_0.01.dat |  3  |  3 |  100 |
| Sprott D	|  data_SprottD_2000_0.01.dat |  3  |  3 |  100 |
| Lorenz	|  data_Lorenz.dat |  3 |  3 |  100 |
| Roessler |  data_roessler2_1000_0.01.dat |  3 |  3 |  100 |
| Chen  | data_chen_1000_0.01.dat |  3 |  3 |  100 |
| Sel'kov |  data_sel_kov_1000_0.01.dat |  2 |  2 |  100 |
| Hyperchaotic Laarem  |  data_hyperchaotic_oscillator_1000_0.01.dat |  4 |  4 |  500 |
| Hyper Sprott B  | data_hyper_sprottB_1000_0.01.dat |  5 |  5 |  500 |


2. Reservoir Hyperparameters for Ten Systems

The values below are randomly generated and then optimized by Bayesian technique. 

| System Name	| W_in_r |  average degree d | spectral radius ρ |
| :--- | :--- | :--- | :---|
| Sprott A	| 0.166903974271684 |	59.1510248401282	| -2.82953128218694 |
| Sprott B	| 0.524801417382458	| 2.80696270207184	| 2.72180624436781  |
| Sprott C	| 0.287709384851287	| 74.0972678053068	| 1.97938743778260  | 
| Sprott D	| 1.03375020271522	| 1	 | 3 |
| Lorenz	| 2.81262506997391	| 94.9666913419282	| -0.730966611140523 |
| Roessler	| 0.958860215120228	| 1.02505593204508	| 2.70376617790837 |
| Chen	| 2.88942563792231	| 6.20808716642222	| -0.0376176384094279 |
| Sel'kov	| 2.23394122119754	| 24.5498565590683	| -0.00227173616567419 |
| Hyperchaotic Laarem	| 0.299007202733509	| 171.705780833805	| -1.21189202441243 |
| Hyper Sprott B	| 0.125746762061917	| 405.335058731385	| 1.53843634290604 |


3. Function Descriptions

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


