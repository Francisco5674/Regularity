function y = ufu(u,k,tau)
y = tau.*(tau+k)./((tau*u+(1-u).*(tau+k)).^2);
end