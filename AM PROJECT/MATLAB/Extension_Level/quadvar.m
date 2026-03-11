% QUADVAR.M
% 4-variable SVAR estimation following Kilian (2009)
% Variables ordered as: (dprod, rea, inv_exp, rpo)
% Sample: January 2006 – September 2025

clear all;
global h t p

% Load data matrix (monthly frequency)
% Columns: oil production growth, real economic activity,
%           expected inventories, real price of oil
load data_expected_inventory_6.txt;
y = data_expected_inventory_6;

% Sample size and number of variables
[t,q] = size(y);

% Monthly time index (aligned with data)
time = (2006 + (0:t-1)'/12);

% SVAR settings
h = 15;    % Impulse response horizon (months)
p = 24;    % VAR lag order

% Reduced-form VAR estimation with intercept
[A,SIGMA,Uhat,V,X] = olsvarc(y,p);

% Retain covariance matrix of reduced-form residuals
SIGMA = SIGMA(1:q,1:q);

