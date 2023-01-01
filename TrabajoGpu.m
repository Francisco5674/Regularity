%% Parameters
I = 100;
l = 0.3;
h = 0.5;
c = 1;
tau = 0.035;
v = [-1,2,32,-2,-10,9];
a = gpuArray(zeros(1,I));
b = gpuArray(ones(1,I));
k = gpuArray(linspace(0.01,1-tau,I));

%% Testing BS
sol = BSvector(@(u) f(u,k,h,l,c,tau),a,b);

%% Testing for a grid
n = 10;
L = gpuArray(linspace(0,1,n));
H = gpuArray(linspace(0,1,n));
C = gpuArray(linspace(1,10,n));
Tau = gpuArray(linspace(0.1,0.9,n));

writematrix(["L","H","C","Tau","Problem"],"Info.csv")

countern = 0;
total = n^4;

for l = L
    for h = H
        for c = C
            for tau = Tau
                if not( l == h) 
                    k = gpuArray(linspace(0.01,1-tau,I));
                    sol = BSvector(@(u) f(u,k,h,l,c,tau),a,b);
                    % Decreasing behaviour 
                    if prod(diff(sol)<0) == 0
                        info = [l,h,c,tau,"Non decreasing"];
                        writematrix(info,'Info.csv','WriteMode','append')
                    end
                    countern = countern + 1;
                    disp(countern*100/total)
                end
            end
        end
    end
end

%% 



%% Testing functions
f(a,c,h,l,C,tau);

%% Function to test

function y = test(x,c)
y = (x.^2 - c).*(-1).^(10*c);
end

%% Function to build 

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
