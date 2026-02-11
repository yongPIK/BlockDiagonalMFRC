
clc;
clear;


fprintf('Loading and preprocessing data...\n');
data_files = {
    'data_SprottA_2000_0.01.dat';
    'data_SprottB_2000_0.01.dat';
    'data_SprottC_2000_0.01.dat';
    'data_SprottD_2000_0.01.dat';
    'data_Lorenz.dat';
    'data_roessler2_1000_0.01.dat';
    'data_chen_1000_0.01.dat';
    'data_sel_kov_1000_0.01.dat';
    'data_hyperchaotic_oscillator_1000_0.01.dat';
    'data_hyper_sprottB_1000_0.01.dat'
};

all_data = cell(10, 1);
for i = 1:10
    P_datas = load(data_files{i});
    data = P_datas';
    
    if i <= 7
        inSize = 3;
    elseif i == 8
        inSize = 2;
    elseif i == 9
        inSize = 4;
    else % i == 10
        inSize = 5;
    end
    
    for j = 1:inSize
        data(j,:) = data(j,:) ./ max(abs(data(j,:)));
    end
    all_data{i} = data;
end

trainlen_vec = [50000 20000 20000 40000 5000 10000 3000 5000 10000 50000];
trainLen = 60000;
inSize_vec = [3 3 3 3 3 3 3 2 4 5];
outSize_vec = [3 3 3 3 3 3 3 2 4 5];
resSize_vec = [100 100 100 100 100 100 100 100 500 500];
testLen = 30000;
initLen = 6000;
gap = 5;


para = [0.1 1e-05 0.166903974271684 59.1510248401282 -2.82953128218694 ...
    0.524801417382458 2.80696270207184 2.72180624436781 0.287709384851287 ...
    74.0972678053068 1.97938743778260 1.03375020271522 1 3 2.81262506997391 ...
    94.9666913419282 -0.730966611140523 0.958860215120228 1.02505593204508 ...
    2.70376617790837 2.88942563792231 6.20808716642222 -0.0376176384094279 ...
    2.23394122119754 24.5498565590683 -0.00227173616567419 0.299007202733509 ...
    171.705780833805 -1.21189202441243 0.125746762061917 405.335058731385 1.53843634290604];

fprintf('Generating weight matrices...\n');
num_experiments = 500;  
num_systems = 10;

Dim_fractal_matrix_true = zeros(num_experiments, num_systems);
Dim_fractal_matrix_pred = zeros(num_experiments, num_systems);


fprintf('Starting %d experiments...\n', num_experiments);
tic;

for exp_idx = 1:num_experiments
    fprintf('\n--- Experiment %d of %d ---\n', exp_idx, num_experiments);
    rng(exp_idx, 'twister');
    W_blocks = cell(1, num_systems);
    Win_blocks = cell(1, num_systems);
    
    for sys_idx = 1:num_systems
        para_idx = (sys_idx-1)*3 + 3;
        W_in_a = para(para_idx);
        k = para(para_idx+1);
        eig_rho = para(para_idx+2);
        Win_blocks{sys_idx} = gene_Win(resSize_vec(sys_idx), inSize_vec(sys_idx), 0, W_in_a, 1);
        W_blocks{sys_idx} = gene_Wr(resSize_vec(sys_idx), k, eig_rho, 1);
    end
    
    W = blkdiag(W_blocks{:});
    resSize_total = sum(resSize_vec);
    fprintf('  Training reservoir...\n');
    X = zeros(resSize_total, trainLen - initLen);
    x = zeros(resSize_total, 1);
    all_inputs = zeros(sum(inSize_vec), trainLen);
    start_idx = 1;
    for sys_idx = 1:num_systems
        end_idx = start_idx + inSize_vec(sys_idx) - 1;
        all_inputs(start_idx:end_idx, :) = all_data{sys_idx}(:, 1:trainLen);
        start_idx = end_idx + 1;
    end
    
    for t = 1:trainLen
        temp_all = zeros(resSize_total, 1);
        start_res = 1;
        start_in = 1;
        
        for sys_idx = 1:num_systems
            end_res = start_res + resSize_vec(sys_idx) - 1;
            end_in = start_in + inSize_vec(sys_idx) - 1;
            
            u_input = all_inputs(start_in:end_in, t);
            temp_all(start_res:end_res) = Win_blocks{sys_idx} * u_input;
            
            start_res = end_res + 1;
            start_in = end_in + 1;
        end
        
        x = (1-para(1)) * x + para(1) * tanh(temp_all + W * x);
        
        if t > initLen
            X(:, t-initLen) = x;
        end
    end
    fprintf('  Training output weights...\n');
    Wout_blocks = cell(1, num_systems);
    res_starts = [0 cumsum(resSize_vec(1:end-1))] + 1;
    res_ends = cumsum(resSize_vec);
    
    for sys_idx = 1:num_systems
        Yt = all_data{sys_idx}(:, trainLen-trainlen_vec(sys_idx)+2:trainLen+1);
        X_segment = X(res_starts(sys_idx):res_ends(sys_idx), end-trainlen_vec(sys_idx)+1:end);
        X_segment_T = X_segment';
        Wout_blocks{sys_idx} = Yt * X_segment_T / (X_segment * X_segment_T + para(2) * eye(resSize_vec(sys_idx)));
    end
    
    fprintf('  Predicting for each system...\n');
    for sys_idx = 1:num_systems
        fprintf('    System %d: ', sys_idx);
        Y_pred = zeros(outSize_vec(sys_idx), testLen);
        Y_true = all_data{sys_idx}(:, trainLen+2:trainLen+testLen+1);
        u = zeros(sum(inSize_vec), 1);
        start_idx = 1;
        for i = 1:num_systems
            end_idx = start_idx + inSize_vec(i) - 1;
            u(start_idx:end_idx) = all_data{i}(:, trainLen+1);
            start_idx = end_idx + 1;
        end
        x_pred = X(:, end);
        for t = 1:testLen
            temp_all = zeros(resSize_total, 1);
            start_res = 1;
            start_in = 1;        
            for i = 1:num_systems
                end_res = start_res + resSize_vec(i) - 1;
                end_in = start_in + inSize_vec(i) - 1;
                
                temp_all(start_res:end_res) = Win_blocks{i} * u(start_in:end_in);
                
                start_res = end_res + 1;
                start_in = end_in + 1;
            end 
            x_pred = (1-para(1)) * x_pred + para(1) * tanh(temp_all + W * x_pred);
            u_pred = Wout_blocks{sys_idx} * x_pred(res_starts(sys_idx):res_ends(sys_idx));
            Y_pred(:, t) = u_pred;
            left_u = zeros(sum(inSize_vec(1:sys_idx-1)), 1);
            right_u = zeros(sum(inSize_vec(sys_idx+1:end)), 1);
            u = [left_u; u_pred; right_u];
        end
        Y_true_T = Y_true';
        Y_pred_T = Y_pred';
        
        Dim_fractal_matrix_true(exp_idx, sys_idx) = Grassberger_Procaccia(...
            inSize_vec(sys_idx), Y_true_T(1:gap:testLen, :));
        Dim_fractal_matrix_pred(exp_idx, sys_idx) = Grassberger_Procaccia(...
            inSize_vec(sys_idx), Y_pred_T(1:gap:testLen, :));
        
        fprintf('Done\n');
    end  
    fprintf('  Experiment %d completed in %.2f seconds\n', exp_idx, toc);
end
addpath('RC_fractal_10sys/');
dlmwrite('RC_fractal_10sys/Dim_fractal_matrix_true_10sys_30000_gap5_fast.dat', ...
    Dim_fractal_matrix_true, 'delimiter', '\t');
dlmwrite('RC_fractal_10sys/Dim_fractal_matrix_pre_10sys_30000_gap5_fast.dat', ...
    Dim_fractal_matrix_pred, 'delimiter', '\t');

fprintf('\nAll experiments completed!\n');
fprintf('Total time: %.2f seconds\n', toc);