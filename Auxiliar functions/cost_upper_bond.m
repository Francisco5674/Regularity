%% Parameters
clear
clc
% This section sets several parameters, this part must be executed before 
% run the next part which solves the general problem
I = 1001;
% "I" represents the number of equation the user wants to solve
% simultaneously, the user can ignore the rest variables.
a = zeros(1,I - 1);
b = ones(1,I - 1);

%% Grid space C as constant (Looking for negligible points)
nl = 10;
% "nl" is the size of the L grid
nh = 10;
% "nh" is the size of the H grid
nc = 100;
% "nc" is the size of the C grid
ntau = 10;
% "ntau" is the size of the Tau grid
L = linspace(0,1,nl);
H = linspace(0,1,nh);
C = linspace(1,100,nc);
Tau = linspace(0.05,0.95,ntau);
% Note that Tau is always between a number different from zero and
% different from one because the equations seem to be undefined in those
% numbers. The limit shows us a problematic behavior.

countern = 0;
total = (nl*nh*nc*ntau - nl*nc*ntau)/2;

Costs = [];
Ind = [];
Muintercept_L = [];
Muintercept_D = [];

for l = L
    for h = H
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
                    
                    if h < Line_L(I-1)
                        if Line_L(I-1) > Line_D(I-1)
                            [intercept, ind] = min(abs(Line_D - Line_L));
                            Costs = [Costs, c];
                            Ind = [Ind, ind];
                            muintercept_L = Line_L(ind);
                            muintercept_D = Line_D(ind);
                            Muintercept_L = [Muintercept_L, muintercept_L];
                            Muintercept_D = [Muintercept_D, muintercept_D];
                        end
                    end
                    
                    % This element displays the progress of the program
                    countern = countern + 1;
                    disp(countern*100/total)

                end
            end
        end
    end
end
% Costs and intercepts

%% How many points are negligible?
scatter(Costs, Ind);
title("Costs and distance to the origin")
xlabel('Costs') 
ylabel('Index in the grid') 

%% Perecentage of relevant points

Relevant_share = [];
Avg_Muintercept = [];
Var_Muintercept = [];
Relevant_tolerance = 5;

for cost = C
    points = Ind(Costs == cost);
    mu_D = Muintercept_D(Costs == cost); 
    mu_L = Muintercept_L(Costs == cost); 
    avg_muintercept = (mu_D + mu_L)*0.5;
    avg_muintercept = mean(avg_muintercept);
    Avg_Muintercept = [Avg_Muintercept, avg_muintercept];
    var_muintercept = (mu_D + mu_L)*0.5;
    var_muintercept = var(var_muintercept);
    Var_Muintercept = [Var_Muintercept, var_muintercept];
    percentage = 1 - (points<Relevant_tolerance);
    percentage = sum(percentage);
    percentage = percentage/length(points);
    Relevant_share = [Relevant_share, percentage];
end

% Pecentage of the relevant points by cost 
plot(C, Relevant_share);
txt_title = "Percentage of relevant records, Limit = ";
txt_tol = num2str(Relevant_tolerance);
txt_title = strcat(txt_title,txt_tol);
title(txt_title)
xlabel('Costs') 
ylabel('% of relevant points') 

%% Mean of the mu intercept by cost
plot(C, Avg_Muintercept);
title("Average mu intercept")
xlabel('Costs')  


