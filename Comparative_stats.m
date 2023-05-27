%% Comparative Statics
clear;

%% Checks if hat_mu is increasing in C

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

%% Checks if hat_mu is increasing in L

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
