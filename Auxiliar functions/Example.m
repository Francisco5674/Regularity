%% Example

clear
clc
tic;
% This section sets several parameters, this part must be executed before 
% run the next part which solves the general problem
I = 10000;
% "I" represents the number of equation the user wants to solve
% simultaneously, the user can ignore the rest variables.
a = zeros(1,I - 1);
b = ones(1,I - 1);
tau_ex=0.2;

c_ex=2;
h_ex=0.8;
l_ex=0.7;

dom = linspace(0.001,1-tau_ex,I);
dom = dom(1:I-1);


L = BSvector(@(u) f(u,dom, ...
    h_ex, ...
    l_ex, ...
    c_ex, ...
    tau_ex),a,b);

plot(dom,L)
title("Example")
xlabel('k') 
ylabel('Mu') 
toc;
%%
tic;
for k = dom
    L = BSvector(@(u) f(u,k, ...
    h_ex, ...
    l_ex, ...
    c_ex, ...
    tau_ex),0,1);
end
plot(dom,L)
title("Example")
xlabel('k') 
ylabel('Mu') 
toc;