function y = ufk(u,k,tau)
y = -tau.*u.*(1-u)./((tau*u+(1-u).*(tau+k)).^2);
end