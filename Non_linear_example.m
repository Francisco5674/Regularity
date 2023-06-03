%% Parameters
clear
clc
% This section sets several parameters, this part must be executed before 
% running the next part which solves the general problem
I = 100;
% "I" = grid size of kappa
a = zeros(1,I);
b = ones(1,I);

%% Example
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