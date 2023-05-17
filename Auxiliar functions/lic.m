function y = lic(u,k,l,c,tau)
y = R(k,l,tau).*(up(u,k,tau) - uf(u,k,tau)) + uf(u,k,tau) - c*k - l;
end