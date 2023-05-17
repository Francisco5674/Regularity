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

%% Grid space C as constant
nl = 11;
% "nl" is the size of the L grid
nh = 11;
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

% Any weird behavior or unexpected is reported in a csv file with their
% parameters and the nature of the problem called "Info.csv".
writematrix(["L","H","C","Tau","Intercept_mu", "Intercept_k",...
    "H_bigger_Int","Intercept?"],"Regular_intercept.csv")

countern = 0;
total = (nl*nh*nc*ntau - nl*nc*ntau)/2;

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
end

%% Example

tau_ex=0.05;
c_ex=50;
h_ex=0.333;
l_ex=0.222;

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

plot(dom,L,dom,D)
title("Example")
xlabel('k') 
ylabel('Mu') 

%% Statistics
clear;
% Tau and when do the lines intercept each other?
regular_intercept = readtable("Regular_intercept.csv");
tabulate(regular_intercept.("Intercept_"));
heatmap(regular_intercept,"Tau","Intercept_");

%% H vs Mu intercept by H
filter = ~isnan(table2array(regular_intercept(:,"H_bigger_Int")));
heatmap(regular_intercept(filter,:),"H","H_bigger_Int");
title("When is H bigger than the intercept?")
xlabel('H') 
ylabel('H > intercept?') 

%% H vs Mu intercept by L
filter = ~isnan(table2array(regular_intercept(:,"H_bigger_Int")));
heatmap(regular_intercept(filter,:),"L","H_bigger_Int");
title("When is H bigger than the intercept?")
xlabel('L')     
ylabel('H > intercept?') 

%% H vs Mu intercept by C
filter = ~isnan(table2array(regular_intercept(:,"H_bigger_Int")));
heatmap(regular_intercept(filter,:),"C","H_bigger_Int");
title("When is H bigger than the intercept?")
xlabel('C')     
ylabel('H > intercept?') ;

%% H comparative static first impression
filter = ~isnan(table2array(regular_intercept(:,"H_bigger_Int")));
regular_inter_mat = table2array(regular_intercept(filter,:));
regular_inter_mat = [regular_inter_mat, disc(regular_inter_mat(:,5))'];

filtered_intercepts = array2table(regular_inter_mat);
heatmap(filtered_intercepts,"regular_inter_mat2","regular_inter_mat9");
title("H comparative statics")
xlabel('H')     
ylabel('mu intercept') ;




