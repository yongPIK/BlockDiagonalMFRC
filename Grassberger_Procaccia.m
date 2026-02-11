function D2 = Grassberger_Procaccia(m,TS)
r_values = logspace(-2, 0, 20); 
Y = TS;
C = zeros(size(r_values));
N = size(Y,1);
for k = 1:length(r_values)
    r = r_values(k);
    count = 0;
    for i = 1:N
        for j = i+1:N
            if norm(Y(i,:) - Y(j,:)) < r
                count = count + 1;
            end
        end
    end
    C(k) = 2 * count / (N*(N-1));
end
log_r = log(r_values);
log_C = log(C);
valid = ~isinf(log_C) & ~isnan(log_C) & log_C > -10; 
p = polyfit(log_r(valid), log_C(valid), 1);
D2 = p(1); 
end
