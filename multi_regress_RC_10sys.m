clc;
clear;

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

trainlen_vec = [50000 20000 20000 40000 5000 10000 3000 5000 10000 50000];
trainLen = 60000;
inSize_vec = [3 3 3 3 3 3 3 2 4 5];
outSize_vec = [3 3 3 3 3 3 3 2 4 5];
testLen = 30000;
initLen = 6000;
resSize_vec = [100 100 100 100 100 100 100 100 500 500];

para = [0.1 1e-05 0.166903974271684 59.1510248401282 -2.82953128218694 ...
    0.524801417382458 2.80696270207184 2.72180624436781 0.287709384851287 ...
    74.0972678053068 1.97938743778260 1.03375020271522 1 3 2.81262506997391 ...
    94.9666913419282 -0.730966611140523 0.958860215120228 1.02505593204508 ...
    2.70376617790837 2.88942563792231 6.20808716642222 -0.0376176384094279 ...
    2.23394122119754 24.5498565590683 -0.00227173616567419 0.299007202733509 ...
    171.705780833805 -1.21189202441243 0.125746762061917 405.335058731385 1.53843634290604];

a = para(1);
reg = para(2);
add_dim = 0;
W_in_type = 1;
W_r_type = 1;

% Create an array of ReservoirSystem objects
systems = cell(1, 10);
for i = 1:10
    systems{i} = ReservoirSystem(data_files{i}, inSize_vec(i), outSize_vec(i), ...
        resSize_vec(i), trainLen, testLen, initLen);
    systems{i} = systems{i}.loadData();
    systems{i} = systems{i}.normalizeData();
    systems{i} = systems{i}.initOutput();
    systems{i} = systems{i}.setTrainingTarget(trainLen, trainlen_vec(i));
    systems{i} = systems{i}.setTestTarget(trainLen);
end

W_blocks = cell(1, 10);
Win_blocks = cell(1, 10);
for i = 1:10
    W_in_a = para(3*i);
    k = para(3*i + 1);
    eig_rho = para(3*i + 2);
    
    systems{i} = systems{i}.initWeights(W_in_a, k, eig_rho, add_dim, W_in_type, W_r_type);
    W_blocks{i} = systems{i}.W;
    Win_blocks{i} = systems{i}.Win;
end

W = blkdiag(W_blocks{:});
resSize = sum(resSize_vec);
X = zeros(resSize, trainLen - initLen);
x = zeros(resSize, 1);

for t = 1:trainLen
    inputs = cell(1, 10);
    for i = 1:10
        inputs{i} = systems{i}.getCurrentInput(t);
    end
    temp_vectors = cell(1, 10);
    for i = 1:10
        temp_vectors{i} = Win_blocks{i} * inputs{i};
    end
    temp = vertcat(temp_vectors{:});
    x = (1 - a) * x + a * tanh(temp + W * x);    
    if t > initLen
        X(:, t - initLen) = x;
    end
end
Wout_blocks = cell(1, 10);
res_start_indices = [0 cumsum(resSize_vec(1:end-1))] + 1;
res_end_indices = cumsum(resSize_vec);

for i = 1:10
    Wout = systems{i}.trainSystem(X, trainlen_vec(i), reg, res_start_indices(i), res_end_indices(i));
    Wout_blocks{i} = Wout;
end

% Testing phase
MODEL = {'SprottA','SprottB','SprottC','SprottD','Lorenz','Roessler','chen','Sel_kov','Hyperchaotic_oscillator','Hyper_sprottB'};

for iii = 1:10
    model = MODEL{iii};
    model_idx = find(strcmp(MODEL, model));
    u = zeros(sum(inSize_vec), 1);
    start_idx = 1;
    for i = 1:10
        end_idx = start_idx + inSize_vec(i) - 1;
        u(start_idx:end_idx) = systems{i}.getInitTestInput(trainLen);
        start_idx = end_idx + 1;
    end
    
    x = X(:, end);
    
    for t = 1:testLen
        u_parts = cell(1, 10);
        start_idx = 1;
        for i = 1:10
            end_idx = start_idx + inSize_vec(i) - 1;
            u_parts{i} = u(start_idx:end_idx);
            start_idx = end_idx + 1;
        end
        temp_vectors = cell(1, 10);
        for i = 1:10
            temp_vectors{i} = Win_blocks{i} * u_parts{i};
        end
        temp = vertcat(temp_vectors{:});
        x = (1 - a) * x + a * tanh(temp + W * x);
        switch model
            case 'SprottA'
                u_pred = Wout_blocks{1} * x(res_start_indices(1):res_end_indices(1));
                systems{1} = systems{1}.updatePrediction(u_pred, t);
                
            case 'SprottB'
                u_pred = Wout_blocks{2} * x(res_start_indices(2):res_end_indices(2));
                systems{2} = systems{2}.updatePrediction(u_pred, t);
                
            case 'SprottC'
                u_pred = Wout_blocks{3} * x(res_start_indices(3):res_end_indices(3));
                systems{3} = systems{3}.updatePrediction(u_pred, t);
                
            case 'SprottD'
                u_pred = Wout_blocks{4} * x(res_start_indices(4):res_end_indices(4));
                systems{4} = systems{4}.updatePrediction(u_pred, t);
                
            case 'Lorenz'
                u_pred = Wout_blocks{5} * x(res_start_indices(5):res_end_indices(5));
                systems{5} = systems{5}.updatePrediction(u_pred, t);
                
            case 'Roessler'
                u_pred = Wout_blocks{6} * x(res_start_indices(6):res_end_indices(6));
                systems{6} = systems{6}.updatePrediction(u_pred, t);
                
            case 'chen'
                u_pred = Wout_blocks{7} * x(res_start_indices(7):res_end_indices(7));
                systems{7} = systems{7}.updatePrediction(u_pred, t);
                
            case 'Sel_kov'
                u_pred = Wout_blocks{8} * x(res_start_indices(8):res_end_indices(8));
                systems{8} = systems{8}.updatePrediction(u_pred, t);
                
            case 'Hyperchaotic_oscillator'
                u_pred = Wout_blocks{9} * x(res_start_indices(9):res_end_indices(9));
                systems{9} = systems{9}.updatePrediction(u_pred, t);
                
            case 'Hyper_sprottB'
                u_pred = Wout_blocks{10} * x(res_start_indices(10):res_end_indices(10));
                systems{10} = systems{10}.updatePrediction(u_pred, t);
        end
        left_u = zeros(sum(inSize_vec(1:model_idx-1)), 1);
        right_u = zeros(sum(inSize_vec(model_idx+1:end)), 1);
        u = [left_u; u_pred; right_u];
    end
    current_system = systems{model_idx};
    figure();
    plot(current_system.Y_target(1, 1:testLen), 'color', [0, 0.75, 0]);
    hold on;
    plot(current_system.Y(1, 1:testLen), 'b');
    hold off;
    axis tight;
    title(['The predicted and true values of the ', model, ' system']);
    legend('Target signal', 'Predicted signal');    
    figure();
    if current_system.outSize >= 3
        plot3(current_system.Y(1, :), current_system.Y(2, :), current_system.Y(3, :));
        title(['Phase space of predicted ', model]);
        xlabel('x'); ylabel('y'); zlabel('z');
    elseif current_system.outSize == 2
        plot(current_system.Y(1, :), current_system.Y(2, :));
        title(['Phase space of predicted ', model]);
        xlabel('x'); ylabel('y');
    end
end