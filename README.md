# BlockDiagonalMFRC
We introduce a novel MFRC framework that overcomes this dependence on attractor separation by employing a modular block-diagonal reservoir structure. Our approach orthogonally projects different chaotic attractors into independent sub-regions of the reservoir's phase space, achieving effective spatial decoupling and precise reconstruction.


Function Descriptions
Function Name	Parameter Description
gene_Win(resSize, inSize, add_dim, W_in_a, W_in_type)	Generates input weight matrix:
- resSize: Reservoir size
- inSize: Input dimension
- add_dim: Whether to add extra dimension (0/1)
- W_in_a: Input weight magnitude
- W_in_type: Weight type (1: uniform distribution, 2: normal distribution)
gene_Wr(resSize, k, eig_rho, W_r_type)	Generates internal reservoir weight matrix:
- resSize: Reservoir size
- k: Average degree (sparsity)
- eig_rho: Desired spectral radius
- W_r_type: Weight type (1: uniform distribution, 2: normal distribution)
Grassberger_Procaccia(dim, data)	Calculates correlation dimension:
- dim: Embedding dimension
- data: Input data matrix (rows: time points, columns: dimensions)
