function y = upu(u,k,tau)
y = (1-tau).*(1-tau-k)./(((1-tau)*u+(1-u).*(1-tau-k)).^2);
end