%% Comparative Stats
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

%% Graphs of mu intercept by c
l = 0.4;
tau = 0.55;

comp_stat_c = readmatrix("Stat_C.csv");
filter = (comp_stat_c(:,1) == l) & (comp_stat_c(:,3) == tau);
comp_stat_c = comp_stat_c(filter,:);
muintercept = comp_stat_c(4:end);

plot(muintercept)

%% Graphs of mu intercept by L
c = 10;
tau = 0.75;

comp_stat_c = readmatrix("Stat_L.csv");
filter = (comp_stat_c(:,2) == c) & (comp_stat_c(:,3) == tau);
comp_stat_c = comp_stat_c(filter,:);
muintercept = comp_stat_c(4:end);

plot(muintercept)

%% Check behaviour of Mu(C)

comp_stat_c = readmatrix("Stat_C.csv");
writematrix(["L","H","Tau","Increasing"],"Check_C.csv")
for i= 1:size(comp_stat_c,1)
    data = comp_stat_c(i,:);
    muintercept = data(4:end);
    muintercept = muintercept(~isnan(muintercept));
    if prod(not(diff(muintercept)<0)) == 0
       info = [data(1:3), 0];
       writematrix(info,'Check_C.csv', ...
                 'WriteMode','append')
    else
       info = [data(1:3), 1];
       writematrix(info,'Check_C.csv', ...
                 'WriteMode','append')
    end
end

%% Check behaviour of Mu(C)

comp_stat_c = readmatrix("Stat_L.csv");
writematrix(["H","C","Tau","Increasing"],"Check_L.csv")
for i= 1:size(comp_stat_c,1)
    data = comp_stat_c(i,:);
    muintercept = data(4:end);
    muintercept = muintercept(~isnan(muintercept));
    if prod(not(diff(muintercept)<0)) == 0
       info = [data(1:3), 0];
       writematrix(info,'Check_L.csv', ...
                 'WriteMode','append')
    else
       info = [data(1:3), 1];
       writematrix(info,'Check_L.csv', ...
                 'WriteMode','append')
    end
end
