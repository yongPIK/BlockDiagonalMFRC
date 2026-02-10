# BlockDiagonalMFRC

A Simple Yet Effective Approach to Multi-Functional Reservoir Computing for Chaotic Time-Series Prediction

by Kaiwen Jiang, Xingang Wang, and Yong Zou

Corresponding author: yzou@phy.ecnu.edu.cn

*Abstract:* 

Reservoir Computing (RC) has been shown to be an efficient paradigm to predict time series in chaotic systems. While the extension to Multi-functional Reservoir Computing (MFRC) has become a promising topic, existing methods struggle to handle attractors that are not strictly separated in phase space, severely limiting their applicability. We introduce a novel MFRC framework that overcomes this dependence on attractor separation by employing a modular block-diagonal reservoir structure. Our approach orthogonally projects different chaotic attractors into independent sub-regions of the reservoir's phase space, achieving effective spatial decoupling and precise reconstruction. This architecture deconstructs a high-dimensional dynamic system into multiple low-dimensional sub-modules, each specifically tuned to capture the dynamics of a particular attractor. Based on the natural decoupling observed in the functional network of a reservoir, we further propose incorporating network modularity into the hyperparameter optimization process. This approach enhances the multi-functional capability of the traditional reservoir computing. Numerical validation demonstrates that our MFRC framework shows versatility and performance in scalability, efficiency, heterogeneous compatibility, and robustness to attractor overlap. Therefore, it provides us with a robust and scalable technical framework for multi-functional learning in complex nonlinear systems.

*Files in the zipped folder:*

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

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=1077
 style='width:807.6pt;border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt;
 mso-yfti-tbllook:1184;mso-padding-alt:0cm 5.4pt 0cm 5.4pt'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=349 valign=top style='width:261.85pt;border:solid windowtext 1.0pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>Function Name<span style='mso-tab-count:
  1'>&nbsp;&nbsp;&nbsp;&nbsp; </span></span></p>
  </td>
  <td width=274 valign=top style='width:205.55pt;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>Description</span></p>
  </td>
  <td width=454 valign=top style='width:12.0cm;border:solid windowtext 1.0pt;
  border-left:none;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>Parameter</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=349 valign=top style='width:261.85pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span class=SpellE><span lang=EN-US>gene_<span
  class=GramE>Win</span></span></span><span class=GramE><span lang=EN-US>(</span></span><span
  class=SpellE><span lang=EN-US>resSize</span></span><span lang=EN-US>, <span
  class=SpellE>inSize</span>, <span class=SpellE>add_dim</span>, <span
  class=SpellE>W_in_a</span>, <span class=SpellE>W_in_type</span>)</span></p>
  </td>
  <td width=274 valign=top style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>Generates input weight matrix</span></p>
  </td>
  <td width=454 valign=top style='width:12.0cm;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>- <span class=SpellE>resSize</span>:
  Reservoir size<o:p></o:p></span></p>
  <p class=MsoNormal><span lang=EN-US>- k: Average degree (sparsity)<o:p></o:p></span></p>
  <p class=MsoNormal><span lang=EN-US>- <span class=SpellE>eig_rho</span>:
  Desired spectral radius<o:p></o:p></span></p>
  <p class=MsoNormal><span lang=EN-US>- <span class=SpellE>W_r_type</span>:
  Weight type (1: uniform distribution, 2: normal distribution)</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2'>
  <td width=349 valign=top style='width:261.85pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span class=SpellE><span lang=EN-US>gene_<span
  class=GramE>Wr</span></span></span><span class=GramE><span lang=EN-US>(</span></span><span
  class=SpellE><span lang=EN-US>resSize</span></span><span lang=EN-US>, k, <span
  class=SpellE>eig_rho</span>, <span class=SpellE>W_r_type</span>)</span></p>
  </td>
  <td width=274 valign=top style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>Generates internal reservoir weight
  matrix</span></p>
  </td>
  <td width=454 valign=top style='width:12.0cm;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>- <span class=SpellE>resSize</span>:
  Reservoir size<o:p></o:p></span></p>
  <p class=MsoNormal><span lang=EN-US>- k: Average degree (sparsity)<o:p></o:p></span></p>
  <p class=MsoNormal><span lang=EN-US>- <span class=SpellE>eig_rho</span>:
  Desired spectral radius<o:p></o:p></span></p>
  <p class=MsoNormal><span lang=EN-US>- <span class=SpellE>W_r_type</span>:
  Weight type (1: uniform distribution, 2: normal distribution)</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;mso-yfti-lastrow:yes'>
  <td width=349 valign=top style='width:261.85pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span class=SpellE><span lang=EN-US>Grassberger_<span
  class=GramE>Procaccia</span></span></span><span class=GramE><span lang=EN-US>(</span></span><span
  lang=EN-US>dim, data)</span></p>
  </td>
  <td width=274 valign=top style='width:205.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>Calculates correlation dimension</span></p>
  </td>
  <td width=454 valign=top style='width:12.0cm;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt'>
  <p class=MsoNormal><span lang=EN-US>- dim: Embedding dimension<o:p></o:p></span></p>
  <p class=MsoNormal><span lang=EN-US>- data: Input data matrix (rows: time
  points, columns: dimensions)</span></p>
  </td>
 </tr>
</table>
