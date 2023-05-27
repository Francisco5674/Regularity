%% Parameters
clear
clc
% This section sets several parameters, this part must be executed before 
% run the next part which solves the general problem
I = 1001;
% "I" represents the number of equation the user wants to solve
% simultaneously. (Number of k and mu)
a = zeros(1,I - 1);
b = ones(1,I - 1);

%% Grid space (C as constant)
nl = 8;
% "nl" is the size of the L grid
nc = 10;
% "nc" is the size of the C grid
ntau = 10;
% "ntau" is the size of the Tau grid
L = linspace(0,0.7,nl);
h = 0.8; % h is not relevant since it only represents an upper bound for L.
C = linspace(2,20,nc);
Tau = linspace(0.05,0.95,ntau);
% Note that Tau is always between a number different from zero and
% different from one because the equations seem to be undefined in those
% numbers.

% All the results will be saved in "Regular_intercept.csv".
%%
writematrix(["L","H","C","Tau","Intercept_mu", "Intercept_k",...
    "H_bigger_Int","Intercept?"],"Regular_intercept.csv")

countern = 0;
total = nl*nc*ntau;

for l = L
        for c = C
            for tau = Tau
                if h>l
                    k = linspace(0.001,1-tau,I);
                    k = k(1:I-1);
                    % mu which marks the difference between the IC slope of
                    % high type and the low type
                    Line_D = BSvector(@(u) f(u,k,h,l,c,tau),a,b);
                    
                    % Checking the valid points and the problematics for
                    % the low type IC
                    [kc,diver,ac,bc,udiver] = ...
                        precheck(@(u) lic(u,k,l,c,tau),a,b,k);
                    Line_L = BSvector(@(u) lic(u,kc,l,c,tau),ac,bc);

                    k = [kc, diver];
                    Line_L = [Line_L, udiver];

                    % looking for intercept
                    [intercept, ind] = min(abs(Line_D - Line_L));
                    if h < Line_L(I-1)
                    
                        if Line_L(I-1) > Line_D(I-1)
                            mu_int = (Line_L(ind) + Line_D(ind))/2;
                            if h>=mu_int
                                info = [l,h,c,tau,mu_int,k(ind),1,1];
                            else
                                info = [l,h,c,tau,mu_int,k(ind),0,1];
                            end
                            
                        else
                            info = [l,h,c,tau,".",".",".",0];
                        end
                        % write each record of the parameters in the csv
                        writematrix(info,'Regular_intercept.csv', ...
                                    'WriteMode','append')
                    end
                    
                    % This element displays the progress of the program
                    countern = countern + 1;
                    disp(countern*100/total)

                end
            end
        end
end

% This creates the files where python filters by the selected variables.
pyrunfile("Comparative_C.py") % Mu(C)
pyrunfile("Comparative_L.py") % Mu(L)


%% Example

tau_ex=0.75;
c_ex=90;
h_ex=0.8;
l_ex=0.3;


dom = linspace(0.001,1-tau_ex,I);
dom = dom(1:I-1);
L = BSvector(@(u) f(u,dom, ...
    h_ex, ...
    l_ex, ...
    c_ex, ...
    tau_ex),a,b);

[dom,diver,ar,br,udiver] = ...
    precheck(@(u) lic(u,dom,l_ex,c_ex,tau_ex),a,b,dom);

D = BSvector(@(u) lic(u,dom, ...
    l_ex, ...
    c_ex, ...
    tau_ex),ar,br);

dom = [dom, diver];
D = [D, udiver];

[intercept, ind] = min(abs(D - L));

plot(dom,L, dom, D)
title("Example")
xlabel('k') 
ylabel('Mu') 
