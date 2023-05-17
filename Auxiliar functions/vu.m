function y = vu(u,k,theta,tau)
y = R(k,theta,tau).*upu(u,k,tau) + (1-R(k,theta,tau)).*ufu(u,k,tau);
end