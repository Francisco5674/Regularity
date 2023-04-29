%% Parameters
clear
clc
% This section sets several parameters, this part must be executed before 
% run the next part which solves the general problem
I = 1001;
% "I" represents the number of equation the user wants to solve
% simultaneously, the user can ignore the rest variables.
l = 0.3;
h = 0.5;
c = 1;
tau = 0.035;
v = [-1,2,32,-2,-10,9];
a = zeros(1,I - 1);
b = ones(1,I - 1);

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
writematrix(["L","H","C","Tau","Intercept_mu", "Intercept_k"],...
    "Regular_intercept.csv")

countern = 0;
total = (nl*nh*nc*ntau - nl*nc*ntau)/2;

for l = L
    for h = H
        for c = C
            for tau = Tau
                if h>l
                    k = linspace(0.01,1-tau,I);
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
                    
                    if Line_L(I-1) > Line_D(I-1)
                        info = [l,h,c,tau,intercept,k(ind)];
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
c_ex=10;
h_ex=0.222;
l_ex=0.111;

dom = linspace(0.001,1-tau_ex,I);
dom = dom(1:I-1);
L = BSvector(@(u) f(u,dom, ...
    h_ex, ...
    l_ex, ...
    c_ex, ...
    tau_ex),a,b);

[dom,diver,a,b,udiver] = precheck(@(u) lic(u,dom,l_ex,c_ex,tau_ex),a,b,dom);

D = BSvector(@(u) lic(u,dom, ...
    l_ex, ...
    c_ex, ...
    tau_ex),a,b);

dom = [dom, diver];
D = [D, udiver];

[intercept, ind] = min(abs(D - L));
disp(dom(ind))

plot(dom,L,dom,D)
title("Example")
xlabel('k') 
ylabel('Mu') 

%% Function to build 

% Low indifference curve

function y = lic(u,k,l,c,tau)
y = R(k,l,tau).*(up(u,k,tau) - uf(u,k,tau)) + uf(u,k,tau) - c*k - l;
end

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
