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

%% Grid space C as constant
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

%%
writematrix(["L","H","C","Tau","Decreasing"],"Regular_case.csv")

countern = 0;
total = nl*nc*ntau;

for l = L
        for c = C
            for tau = Tau
                if h>l
                    k = linspace(0.01,1-tau,I);
                    sol = BSvector(@(u) f(u,k,h,l,c,tau),a,b);
                    % In case of decreasing behavior 
                    if prod(not(diff(sol)>0)) == 0
                        info = [l,h,c,tau,0];
                        writematrix(info,'Regular_case.csv', ...
                            'WriteMode','append')
                    else
                        info = [l,h,c,tau,1];
                        writematrix(info,'Regular_case.csv', ...
                            'WriteMode','append')
                    end
                    countern = countern + 1;
                    disp(countern*100/total)
                end
            end
        end
end

%% Grid space C as a function
nl = 10;
% "nl" is the size of the L grid
nh = 10;
% "nh" is the size of the H grid
nc = 10;
% "nc" is the size of the C grid
ntau = 10;
% "ntau" is the size of the Tau grid
nA = 10;
% "nA" is the sice of the A grid
L = linspace(0,1,nl);
H = linspace(0,1,nh);
Tau = linspace(0.05,0.95,ntau);
Alist = linspace(0,10,nA);
P = [1/3,1/2,2,3];
% Note that Tau is always between a number different from zero and
% different from one because the equations seem to be undefined in those
% numbers. The limit shows us a problematic behavior.

% Any weird behavior or unexpected is reported in a csv file with their
% parameters and the nature of the problem called "Info.csv".
writematrix(["L","H","Tau","P","A","Decreasing"],"Unregular_case.csv")

countern = 0;
total = (nl*nh*4*ntau*nA - nh*4*ntau*nA)/2;

for l = L
    for h = H
        for p = P
            for tau = Tau
                for A = Alist
                if h > l 
                    k = linspace(0.01,1-tau,I);
                    sol = BSvector(@(u) g(u,k,h,l,tau,p,A),a,b);
                    % In case of decreasing behavior 
                    if prod(not(diff(sol)>0)) == 0
                        info = [l,h,tau,p,A,0];
                        writematrix(info,'Unregular_case.csv', ...
                            'WriteMode','append')
                    else
                        info = [l,h,tau,p,A,1];
                        writematrix(info,'Unregular_case.csv', ...
                            'WriteMode','append')
                    end
                    countern = countern + 1;
                    disp(countern*100/total)
                end
                end
            end
        end
    end
end
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