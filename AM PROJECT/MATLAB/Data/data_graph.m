% Load data
T = readtable('compare.txt','Delimiter',' ');

% Convert Month
T.Month = datetime(T.Month,'InputFormat','yyyy-MM-dd');

figure

% 1. dProd
subplot(3,1,1)
plot(T.Month, T.dprod, 'k','LineWidth',1)
grid on
title('Oil Production Growth')

% 2. REA
subplot(3,1,2)
plot(T.Month, T.REA, 'g','LineWidth',1); hold on
plot(T.Month, T.rea, 'k','LineWidth',1)
grid on
title('Real Economic Activity')
legend('Old','Updated','Location','best')

% 3. RPO
subplot(3,1,3)
plot(T.Month, T.rpo, 'k','LineWidth',1)
grid on
title('Real Price of Oil')
