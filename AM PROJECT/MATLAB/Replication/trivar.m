% TRIVAR.M
% Replication of Kilian (2009) baseline SVAR
% Original framework by Lutz Kilian (University of Michigan)
% Monthly data, replication sample: 1974.1–2007.12

clear all;

global h t

% Load monthly data ordered as:
% 1. Growth rate of world crude oil production
% 2. Index of global real economic activity (dry cargo shipping rates)
% 3. Real price of crude oil
% Data sources and transformations follow Kilian (2009)

load kilian_replication.txt;
y = kilian_replication;
[t,q] = size(y);

% Monthly time index
time = (1974 : 1/12 : 2007+11/12)';

% Model settings
h = 15;    % Impulse response horizon (months)
p = 24;    % VAR lag order

% Estimate reduced-form VAR with intercept
[A,SIGMA,Uhat,V,X] = olsvarc(y,p);
SIGMA = SIGMA(1:q,1:q);
