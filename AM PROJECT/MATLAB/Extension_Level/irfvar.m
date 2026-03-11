function [IRF]=irfvar(A,SIGMA,p,h)
% IRFVAR.M - Structural IRF (Cholesky)

q = size(SIGMA,1);
J = [eye(q,q) zeros(q,q*(p-1))];

% Impact (h=0)
IRF = reshape(J*A^0*J'*chol(SIGMA)', q^2, 1);

% Propagation (h=1...h)
for i=1:h
    IRF = [IRF reshape(J*A^i*J'*chol(SIGMA)', q^2, 1)];
end
