%% Parameters
clear
clc
% This section sets several parameters, this part must be executed before 
% run the next part which solves the general problem
I = 100;
% "I" represents the number of equation the user wants to solve
% simultaneously, the user can ignore the rest variables.
v = [-1,2,32,-2,-10,9];
a = zeros(1,I);
b = ones(1,I);

% Grid space C as constant
nl = 10;
% "nl" is the size of the L grid
nc = 10;
% "nc" is the size of the C grid
ntau = 10;
% "ntau" is the size of the Tau grid
h = 0.8;
L = linspace(0,h,nl);
C = linspace(1,10,nc);
Tau = linspace(0.05,0.95,ntau);
% Note that Tau is always between a number different from zero and
% different from one because the equations seem to be undefined in those
% numbers. The limit shows us a problematic behavior.

% Any weird behavior or unexpected is reported in a csv file with their
% parameters and the nature of the problem called "Info.csv".

%% Example of increasing behavior.
weirdsol = BSvector(@(u) g(u,linspace(0.001,0.95,100), ...
    1, ...
    0.88889, ...
    0.05, ...
    0.333, ...
    10),a,b);
plot(linspace(0.001,0.95,100),weirdsol)
title("Example unregular situation")
xlabel('k') 
ylabel('Mu') 

% Little Tau + Big A, no matter H or L, P<1.