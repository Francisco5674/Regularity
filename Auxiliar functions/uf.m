function y = uf(u,k,tau)
y = tau.*u./(tau*u+(1-u).*(tau+k));
end
