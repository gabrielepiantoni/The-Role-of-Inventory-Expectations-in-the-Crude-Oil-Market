function [A,SIGMA,U,V,X]=olsvarc(y,p)
% OLSVARC.M - Level VAR estimation

[t,q]=size(y);
y=y';

% Lag Matrix
Y=y(:,p:t);
for i=1:p-1
    Y=[Y; y(:,p-i:t-i)];
end

% Regressors X (Intercept + Lags)
X=[ones(1,t-p); Y(:,1:t-p)];

% LHS Variable
Y_lhs = y(:, p+1:t);

% OLS
B = (Y_lhs*X')/(X*X');

% Residuals & Sigma
U = Y_lhs - B*X;
SIGMA = U*U'/(t-p-p*q-1);

% Companion Matrix Components
V = B(:,1);
A_coeffs = B(:,2:end);
A = [A_coeffs; eye(q*(p-1)) zeros(q*(p-1),q)];
