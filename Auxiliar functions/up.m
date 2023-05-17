function y = up(u,k,tau)
y = u.*(1-tau)./((1-tau)*u+(1-u).*(1-tau-k));
end
