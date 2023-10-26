%% Parameters
clear
clc
% This section sets several parameters, this part must be executed before 
% running the next part which solves the general problem
I = 1001;
% "I" = grid size of kappa
a = zeros(1,I - 1);
b = ones(1,I - 1);

%% Grid space for parameters
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
% Note that Tau is neither zero nor one.

% All the results will be saved in "Regular_intercept.csv" and 
% "Regular_decreasing.csv".
%%
writematrix(["L","H","C","Tau","hat_mu", "hat_kappa",...
    "Intercept"],"Outputs\Regular_intercept.csv")
writematrix(["L","H","C","Tau","Decreasing"],"Outputs\Regular_case.csv")

countern = 0;
total = nl*nc*ntau;

for l = L
        for c = C
            for tau = Tau
                if h>l
                    k = linspace(0.001,1-tau,I);
                    k = k(1:I-1);
                    % Line_D = mu tilde of kappa
                    Line_D = BSvector(@(u) f(u,k,h,l,c,tau),a,b);

                    if prod(not(diff(Line_D)>0)) == 0
                        info = [l,h,c,tau,0];
                        writematrix(info,'Outputs\Regular_case.csv', ...
                            'WriteMode','append')
                    else
                        info = [l,h,c,tau,1];
                        writematrix(info,'Outputs\Regular_case.csv', ...
                            'WriteMode','append')
                    end
                   
                    [kc,diver,ac,bc,udiver] = ...
                        precheck(@(u) lic(u,k,l,c,tau),a,b,k);
                    %Line_L = Indifference curve of type L
                    Line_L = BSvector(@(u) lic(u,kc,l,c,tau),ac,bc);

                    k = [kc, diver];
                    Line_L = [Line_L, udiver];

                    % find the intercept, hat_mu
                    [intercept, ind] = min(abs(Line_D - Line_L));
                    if h < Line_L(I-1)
                    
                        if Line_L(I-1) > Line_D(I-1)
                            mu_int = (Line_L(ind) + Line_D(ind))/2;
                            info = [l,h,c,tau,mu_int,k(ind),1];
                        else
                            info = [l,h,c,tau,".",".",0];
                        end
                        % write in the csv
                        writematrix(info,'Outputs\Regular_intercept.csv', ...
                                    'WriteMode','append')
                    end
                    
                    % This element displays the progress of the program
                    countern = countern + 1;
                    disp(countern*100/total)

                end
            end
        end
end

% This creates the files in python for the comparative statics.
% Writes hat_mu as a function of C or L.
pyrunfile("Auxiliar functions python\Comparative_C.py") % hat_mu(C) 
pyrunfile("Auxiliar functions python\Comparative_L.py") % hat_mu(L)