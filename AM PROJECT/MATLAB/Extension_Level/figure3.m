% FIGURE3.M
% IRF with Confidence Intervals for 4-Variable SVAR
% Var Order: 1.Prod(Diff) - 2.REA(Level) - 3.ExpInv(LogLevel) - 4.Price(LogLevel)

clear; 
quadvar; 

%% 1. Point Estimates
[IRF] = irfvar(A,SIGMA,p,h);

% CUMULATE ONLY VARIABLE 1 
IRF(1,:)  = cumsum(IRF(1,:));  
IRF(5,:)  = cumsum(IRF(5,:));  
IRF(9,:)  = cumsum(IRF(9,:));  
IRF(13,:) = cumsum(IRF(13,:)); 

%% 2. Bootstrap
randn('seed',1234);
nrep = 2000;
IRFmat = zeros(nrep,(q^2)*(h+1));

% Bootstrap Data Setup
y = y'; % [q x T]
Ur = zeros(q, t-p);
Yr = zeros(q, t);
U  = Uhat(1:q, :);
V_const = V(:, 1); 

disp('Starting Bootstrap...');
for r = 1:nrep
    if mod(r,100)==0, disp(['Replication ', num2str(r)]), end
    
    % Wild Bootstrap Shocks
    eta = randn(1, size(U,2));
    U_boot = U .* repmat(eta, q, 1);
    
    % Initialize Recursion
    Yr(:, 1:p) = y(:, 1:p);
    A_var = A(1:q, :); 
    
    % Recursion
    for i = p+1 : t
        lags = [];
        for k = 1:p
            lags = [lags; Yr(:, i-k)];
        end
        Yr(:, i) = V_const + A_var * lags + U_boot(:, i-p);
    end
    
    % Re-estimation
    [Ar, SIGMAr] = olsvarc(Yr', p);
    IRFr = irfvar(Ar, SIGMAr, p, h);
    
    % Cumulate ONLY Prod
    IRFr(1,:)  = cumsum(IRFr(1,:));
    IRFr(5,:)  = cumsum(IRFr(5,:));
    IRFr(9,:)  = cumsum(IRFr(9,:));
    IRFr(13,:) = cumsum(IRFr(13,:));
    
    IRFmat(r,:) = vec(IRFr)';
end

%% 3. Confidence Intervals
IRFrstd = reshape((std(IRFmat)'), q^2, h+1);
CI1LO = IRF - 1*IRFrstd; CI1UP = IRF + 1*IRFrstd;
CI2LO = IRF - 2*IRFrstd; CI2UP = IRF + 2*IRFrstd;

%% 4. PLOTTING
time_irf = 0:h;
figure('Name', 'IRF Quad-Variate Model: Log Level Inventory');

% --- SHOCK 1: OIL SUPPLY SHOCK ---
subplot(4,4,1)
plot(time_irf,-IRF(1,:),'r-',time_irf,-CI1LO(1,:),'b--',time_irf,-CI1UP(1,:),'b--', ...
     time_irf,-CI2LO(1,:),'b:',time_irf,-CI2UP(1,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.02 0.02]) % <--- ADJUST Y-AXIS HERE
ylabel('Oil production')
title('Oil supply shock')

subplot(4,4,2)
plot(time_irf,-IRF(2,:),'r-',time_irf,-CI1LO(2,:),'b--',time_irf,-CI1UP(2,:),'b--', ...
     time_irf,-CI2LO(2,:),'b:',time_irf,-CI2UP(2,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -20 30]) % <--- ADJUST Y-AXIS HERE
ylabel('Real activity')
title('Oil supply shock')

subplot(4,4,3)
plot(time_irf,-IRF(3,:),'r-',time_irf,-CI1LO(3,:),'b--',time_irf,-CI1UP(3,:),'b--', ...
     time_irf,-CI2LO(3,:),'b:',time_irf,-CI2UP(3,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.05 0.05]) % <--- ADJUST Y-AXIS HERE (Log Inventory Scale)
ylabel('Exp. Inventory')
title('Oil supply shock')

subplot(4,4,4)
plot(time_irf,-IRF(4,:),'r-',time_irf,-CI1LO(4,:),'b--',time_irf,-CI1UP(4,:),'b--', ...
     time_irf,-CI2LO(4,:),'b:',time_irf,-CI2UP(4,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.06 0.2]) % <--- ADJUST Y-AXIS HERE
ylabel('Real price of oil')
title('Oil supply shock')

% --- SHOCK 2: AGGREGATE DEMAND SHOCK ---
subplot(4,4,5)
plot(time_irf,IRF(5,:),'r-',time_irf,CI1LO(5,:),'b--',time_irf,CI1UP(5,:),'b--', ...
     time_irf,CI2LO(5,:),'b:',time_irf,CI2UP(5,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.02 0.02]) % <--- ADJUST Y-AXIS HERE
ylabel('Oil production')
title('Aggregate demand shock')

subplot(4,4,6)
plot(time_irf,IRF(6,:),'r-',time_irf,CI1LO(6,:),'b--',time_irf,CI1UP(6,:),'b--', ...
     time_irf,CI2LO(6,:),'b:',time_irf,CI2UP(6,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -20 30]) % <--- ADJUST Y-AXIS HERE
ylabel('Real activity')
title('Aggregate demand shock')

subplot(4,4,7)
plot(time_irf,IRF(7,:),'r-',time_irf,CI1LO(7,:),'b--',time_irf,CI1UP(7,:),'b--', ...
     time_irf,CI2LO(7,:),'b:',time_irf,CI2UP(7,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.05 0.05]) % <--- ADJUST Y-AXIS HERE (Log Inventory Scale)
ylabel('Exp. Inventory')
title('Aggregate demand shock')

subplot(4,4,8)
plot(time_irf,IRF(8,:),'r-',time_irf,CI1LO(8,:),'b--',time_irf,CI1UP(8,:),'b--', ...
     time_irf,CI2LO(8,:),'b:',time_irf,CI2UP(8,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.06 0.2]) % <--- ADJUST Y-AXIS HERE
ylabel('Real price of oil')
title('Aggregate demand shock')

% --- SHOCK 3: INVENTORY EXPECTATION SHOCK ---
subplot(4,4,9)
plot(time_irf,-IRF(9,:),'r-',time_irf,-CI1LO(9,:),'b--',time_irf,-CI1UP(9,:),'b--', ...
     time_irf,-CI2LO(9,:),'b:',time_irf,-CI2UP(9,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.02 0.02])
ylabel('Oil production')
title('Oil-specific precautionary demand')

subplot(4,4,10)
plot(time_irf,-IRF(10,:),'r-',time_irf,-CI1LO(10,:),'b--',time_irf,-CI1UP(10,:),'b--', ...
     time_irf,-CI2LO(10,:),'b:',time_irf,-CI2UP(10,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -20 30])
ylabel('Real activity')
title('Oil-specific precautionary demand')

subplot(4,4,11)
plot(time_irf,-IRF(11,:),'r-',time_irf,-CI1LO(11,:),'b--',time_irf,-CI1UP(11,:),'b--', ...
     time_irf,-CI2LO(11,:),'b:',time_irf,-CI2UP(11,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.05 0.05])
ylabel('Exp. Inventory')
title('Oil-specific precautionary demand')

subplot(4,4,12)
plot(time_irf,-IRF(12,:),'r-',time_irf,-CI1LO(12,:),'b--',time_irf,-CI1UP(12,:),'b--', ...
     time_irf,-CI2LO(12,:),'b:',time_irf,-CI2UP(12,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.06 0.2])
ylabel('Real price of oil')
title('Oil-specific precautionary demand')
% --- SHOCK 4: OIL-SPECIFIC DEMAND SHOCK ---
subplot(4,4,13)
plot(time_irf,IRF(13,:),'r-',time_irf,CI1LO(13,:),'b--',time_irf,CI1UP(13,:),'b--', ...
     time_irf,CI2LO(13,:),'b:',time_irf,CI2UP(13,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.02 0.02]) % <--- ADJUST Y-AXIS HERE
ylabel('Oil production')
xlabel('Months')
title('Oil-specific residual demand shock')

subplot(4,4,14)
plot(time_irf,IRF(14,:),'r-',time_irf,CI1LO(14,:),'b--',time_irf,CI1UP(14,:),'b--', ...
     time_irf,CI2LO(14,:),'b:',time_irf,CI2UP(14,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -20 30]) % <--- ADJUST Y-AXIS HERE
ylabel('Real activity')
xlabel('Months')
title('Oil-specific residual demand shock')

subplot(4,4,15)
plot(time_irf,IRF(15,:),'r-',time_irf,CI1LO(15,:),'b--',time_irf,CI1UP(15,:),'b--', ...
     time_irf,CI2LO(15,:),'b:',time_irf,CI2UP(15,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.05 0.05]) % <--- ADJUST Y-AXIS HERE
ylabel('Exp. Inventory')
xlabel('Months')
title('Oil-specific residual demand shock')

subplot(4,4,16)
plot(time_irf,IRF(16,:),'r-',time_irf,CI1LO(16,:),'b--',time_irf,CI1UP(16,:),'b--', ...
     time_irf,CI2LO(16,:),'b:',time_irf,CI2UP(16,:),'b:',time_irf,zeros(size(time_irf)),'k-')
axis([0 h -0.06 0.2]) % <--- ADJUST Y-AXIS HERE
ylabel('Real price of oil')
xlabel('Months')
title('Oil-specific residual demand shock')

set(gcf,'Visible','on');
drawnow;
