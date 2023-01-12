%% Parameters
clear
clc
% This section sets several parameters, this part must be executed before 
% run the next part which solves the general problem
I = 100;
% "I" represents the number of equation the user wants to solve
% simultaneously, the user can ignore the rest variables.
l = 0.3;
h = 0.5;
c = 1;
tau = 0.035;
v = [-1,2,32,-2,-10,9];
a = zeros(1,I);
b = ones(1,I);
k = linspace(0.01,1-tau,I);

%% Grid space C as constant
nl = 10;
% "nl" is the size of the L grid
nh = 10;
% "nh" is the size of the H grid
nc = 10;
% "nc" is the size of the C grid
ntau = 10;
% "ntau" is the size of the Tau grid
L = linspace(0,1,nl);
H = linspace(0,1,nh);
C = linspace(1,10,nc);
Tau = linspace(0.05,0.95,ntau);
% Note that Tau is always between a number different from zero and
% different from one because the equations seem to be undefined in those
% numbers. The limit shows us a problematic behavior.

% Any weird behavior or unexpected is reported in a csv file with their
% parameters and the nature of the problem called "Info.csv".
writematrix(["L","H","C","Tau","Decreasing"],"Regular_case.csv")

countern = 0;
total = nl*nh*nc*ntau - nl*nc*ntau;

for l = L
    for h = H
        for c = C
            for tau = Tau
                % For some reason, L must be different from H becasue the
                % equations get undefined 
                if not( l == h) 
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
total = nl*nh*4*ntau*nA - nh*4*ntau*nA;

for l = L
    for h = H
        for p = P
            for tau = Tau
                for A = Alist
                % For some reason, L must be different from H becasue the
                % equations get undefined 
                if not( l == h) 
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
plot(weirdsol)

% Little Tau + Big A, no matter H or L, P<1.

%% Function to build 

% C as a function of k
function y = g(u,k,h,l,tau,p,A)
y = ((ck(A,p,l,k) - vk(u,k,h,tau)).*vu(u,k,l,tau))-...
    ((ck(A,p,l,k) - vk(u,k,l,tau)).*vu(u,k,h,tau));
end

function r = ck(A,p,l,k)
r = A.*p.*k.^(p-1) + (1-l)*0.5;
end

% C is constant
function y = f(u,k,h,l,c,tau)
y = ((c - vk(u,k,h,tau)).*vu(u,k,l,tau))-...
    ((c - vk(u,k,l,tau)).*vu(u,k,h,tau));
end

function y = vu(u,k,theta,tau)
y = R(k,theta,tau).*upu(u,k,tau) + (1-R(k,theta,tau)).*ufu(u,k,tau);
end

function y = vk(u,k,theta,tau)
y = -(1-theta).*(up(u,k,tau)-uf(u,k,tau)) ... 
    + R(k,theta,tau).*upk(u,k,tau) + (1-R(k,theta,tau)).*ufk(u,k,tau);
end

function y = upu(u,k,tau)
y = (1-tau).*(1-tau-k)./(((1-tau)*u+(1-u).*(1-tau-k)).^2);
end

function y = upk(u,k,tau)
y = u.*(1-tau).*(1-u)./(((1-tau)*u+(1-u).*(1-tau-k)).^2);
end

function y = ufu(u,k,tau)
y = tau.*(tau+k)./((tau*u+(1-u).*(tau+k)).^2);
end

function y = ufk(u,k,tau)
y = -tau.*u.*(1-u)./((tau*u+(1-u).*(tau+k)).^2);
end

function y = R(k,theta,tau)
y = (1-tau-(1-theta).*k);
end

function y = up(u,k,tau)
y = u.*(1-tau)./((1-tau)*u+(1-u).*(1-tau-k));
end

function y = uf(u,k,tau)
y = tau.*u./(tau*u+(1-u).*(tau+k));
end
