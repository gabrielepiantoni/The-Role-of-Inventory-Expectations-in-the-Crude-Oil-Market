% Inverted_FIGURE4.M
% Historical decomposition – INVERTED ORDER
% Variable order (4-var): (dprod, rea, rpo, inv_exp)
% Shock order:
% 1. Oil supply (Prod)
% 2. Aggregate demand
% 3. Residual oil-specific demand
% 4. Precautionary (inventory) demand

clear;
quadvar_inverted;

%% 1. STRUCTURAL DECOMPOSITION (4-VARIABLE MODEL)

IRF_hist = irfvar(A, SIGMA(1:q,1:q), p, t-p-1);
P = chol(SIGMA(1:q,1:q))';
Ehat = P \ Uhat(1:q,:);

len   = t - p;
yhat1 = zeros(len,1);
yhat2 = zeros(len,1);
yhat3 = zeros(len,1);
yhat4 = zeros(len,1);

% With inverted variable order, rpo is variable 3 → rows:
% shock s, variable v  → row = (s-1)*q + v
idx1 = 3;   % rpo response to shock 1 (oil supply)
idx2 = 7;   % rpo response to shock 2 (agg demand)
idx3 = 11;  % rpo response to shock 3 (residual demand)
idx4 = 15;  % rpo response to shock 4 (precautionary demand)

for i = 1:len
    yhat1(i) = dot(IRF_hist(idx1,1:i), Ehat(1,i:-1:1));
    yhat2(i) = dot(IRF_hist(idx2,1:i), Ehat(2,i:-1:1));
    yhat3(i) = dot(IRF_hist(idx3,1:i), Ehat(3,i:-1:1));
    yhat4(i) = dot(IRF_hist(idx4,1:i), Ehat(4,i:-1:1));
end

%% 2. TIME ALIGNMENT
time_plot = time(p+1:p+len);

%% 3. HISTORICAL CUMULATIVE CONTRIBUTION (4-VAR ONLY)

ymin = -1.5;
ymax =  0.5;

figure;

subplot(4,1,1)
plot(time_plot,yhat1,'b-');
title('Oil supply shock contribution')
axis([time_plot(1) time_plot(end) ymin ymax])
grid on

subplot(4,1,2)
plot(time_plot,yhat2,'b-');
title('Aggregate demand shock contribution')
axis([time_plot(1) time_plot(end) ymin ymax])
grid on

subplot(4,1,3)
plot(time_plot,yhat3,'b-');
title('Oil-specific residual demand contribution')
axis([time_plot(1) time_plot(end) ymin ymax])
grid on

subplot(4,1,4)
plot(time_plot,yhat4,'b-');
title('Oil-specific precautionary demand contribution')
axis([time_plot(1) time_plot(end) ymin ymax])
grid on
