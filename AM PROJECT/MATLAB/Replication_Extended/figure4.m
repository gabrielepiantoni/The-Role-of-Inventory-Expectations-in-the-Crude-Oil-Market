% FIGURE4.M
% Replication of Figure 4 in Kilian (2009)
% Historical decomposition of the real price of crude oil
% Decomposition into oil supply, aggregate demand, and oil-specific demand shocks
% Extended sample ending in September 2025

clear;
trivar

%%%%%%%%%% Historical decomposition %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute structural impulse responses over the effective sample

IRF = irfvar(A, SIGMA(1:q,1:q), p, t-p-1);

% Recover structural shocks from reduced-form residuals
Ehat = inv(chol(SIGMA)') * Uhat(1:q,:);

% Initialize cumulative contributions to the real price of oil
yhat1 = zeros(t-p,1);   % Oil supply shocks
yhat2 = zeros(t-p,1);   % Aggregate demand shocks
yhat3 = zeros(t-p,1);   % Oil-specific demand shocks

% Construct historical decomposition via convolution of IRFs and shocks
for i = 1:t-p
    yhat1(i) = dot(IRF(3,1:i), Ehat(1,i:-1:1));
    yhat2(i) = dot(IRF(6,1:i), Ehat(2,i:-1:1));
    yhat3(i) = dot(IRF(9,1:i), Ehat(3,i:-1:1));
end

%%%%%%%%%% Time alignment %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Monthly time index consistent with the effective SVAR sample
% The starting date reflects the loss of initial observations due to VAR lags

time_plot = (1974 + p/12 : 1/12 : 2025 + 8/12)';
time_plot = time_plot(1:length(yhat1));

%%%%%%%%%% Dynamic scaling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Common vertical scale across subplots for comparability

ymin = min([yhat1; yhat2; yhat3]);
ymax = max([yhat1; yhat2; yhat3]);
pad  = 0.1 * (ymax - ymin);

%%%%%%%%%% Plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cumulative contribution of each structural shock to the real price of oil

figure;

subplot(3,1,1)
plot(time_plot, yhat1, 'b-');
title('Cumulative Effect of Oil Supply Shock on Real Price of Crude Oil')
axis([time_plot(1) time_plot(end) ymin-pad ymax+pad])
grid on

subplot(3,1,2)
plot(time_plot, yhat2, 'b-');
title('Cumulative Effect of Aggregate Demand Shock on Real Price of Crude Oil')
axis([time_plot(1) time_plot(end) ymin-pad ymax+pad])
grid on

subplot(3,1,3)
plot(time_plot, yhat3, 'b-');
title('Cumulative Effect of Oil-Market Specific Demand Shock on Real Price of Crude Oil')
axis([time_plot(1) time_plot(end) ymin-pad ymax+pad])
grid on
