% TRIVAR.M
% Replication and extension of Kilian (2009) baseline SVAR
% Original framework by Lutz Kilian (University of Michigan)
% Monthly data, extended sample: January 2000 – September 2025

clear all;

global h t

% Load monthly data ordered as:
% 1. Growth rate of world crude oil production
% 2. Index of global real economic activity (dry cargo shipping rates)
% 3. Real price of crude oil
% Data construction and transformations follow Kilian (2009)

load kilian_replication_extended.txt;
y = kilian_replication_extended;
[t,q] = size(y);

% Monthly time index (January 1974 – September 2025)
time = (1974 : 1/12 : 2025+8/12)';

% Model settings
h = 15;    % Impulse response horizon (months)
p = 24;    % VAR lag order

% Estimate reduced-form VAR with intercept
[A,SIGMA,Uhat,V,X] = olsvarc(y,p);
SIGMA = SIGMA(1:q,1:q);
