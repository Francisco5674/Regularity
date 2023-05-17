function y = upk(u,k,tau)
y = u.*(1-tau).*(1-u)./(((1-tau)*u+(1-u).*(1-tau-k)).^2);
end