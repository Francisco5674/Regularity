%% Parameters
n = 3;
l = 0.3;
h = 0.5;
C = 1;
tau = 0.035;
v = [-1,2,32,-2,-10,9];
a = zeros(1,n);
b = ones(1,n);
k = linspace(0.01,1-tau,n);

%% Testing BS

sol = BSvector(@(u) f(u,k,h,l,C,tau),a,b);

%%
plot(sol);

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
