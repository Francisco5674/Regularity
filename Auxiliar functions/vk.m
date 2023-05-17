function y = vk(u,k,theta,tau)
y = -(1-theta).*(up(u,k,tau)-uf(u,k,tau)) ... 
    + R(k,theta,tau).*upk(u,k,tau) + (1-R(k,theta,tau)).*ufk(u,k,tau);
end