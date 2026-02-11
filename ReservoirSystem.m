
classdef ReservoirSystem
    properties
        P_datas
        data
        normalized_data
        data_file
        inSize
        outSize
        resSize
        trainLen
        testLen
        initLen
        Win
        W
        Wout
        Y
        Yt
        Y_target
    end
    
    methods
        function obj = ReservoirSystem(data_file, inSize, outSize, resSize, trainLen, testLen, initLen)
            obj.data_file = data_file;
            obj.inSize = inSize;
            obj.outSize = outSize;
            obj.resSize = resSize;
            obj.trainLen = trainLen;
            obj.testLen = testLen;
            obj.initLen = initLen;
        end
        function obj = loadData(obj)
            obj.P_datas = load(obj.data_file);
            obj.data = obj.P_datas';
        end
        function obj = normalizeData(obj)
            obj.normalized_data = obj.data;
            for i = 1:obj.inSize
                obj.normalized_data(i,:) = obj.normalized_data(i,:) ./ max(abs(obj.normalized_data(i,:)));
            end
        end
        function obj = initWeights(obj, W_in_a, k, eig_rho, add_dim, W_in_type, W_r_type)
            obj.Win = gene_Win(obj.resSize, obj.inSize, add_dim, W_in_a, W_in_type);
            obj.W = gene_Wr(obj.resSize, k, eig_rho, W_r_type);
        end
        function obj = initOutput(obj)
            obj.Y = zeros(obj.outSize, obj.testLen);
        end
        function obj = setTrainingTarget(obj, trainLen_total, trainLen_system)
            obj.Yt = obj.normalized_data(:, trainLen_total - trainLen_system + 2:trainLen_total + 1);
        end
        function obj = setTestTarget(obj, trainLen_total)
            obj.Y_target = obj.normalized_data(:, trainLen_total + 2:trainLen_total + obj.testLen + 1);
        end
        function Wout = trainSystem(obj, X_global, trainLen_system, reg, start_idx, end_idx)
            X_segment = X_global(start_idx:end_idx, end - trainLen_system + 1:end);
            X_segment_T = X_segment';
            Wout = obj.Yt * X_segment_T / (X_segment * X_segment_T + reg * eye(obj.resSize));
            obj.Wout = Wout;
        end
        function u = getCurrentInput(obj, t)
            u = obj.normalized_data(:, t);
        end
        function u = getInitTestInput(obj, trainLen_total)
            u = obj.normalized_data(:, trainLen_total + 1);
        end
        function obj = updatePrediction(obj, u_pred, t)
            obj.Y(:, t) = u_pred;
        end
    end
end