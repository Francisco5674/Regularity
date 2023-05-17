function y = f(u,k,h,l,c,tau)
y = ((c - vk(u,k,h,tau)).*vu(u,k,l,tau))-...
    ((c - vk(u,k,l,tau)).*vu(u,k,h,tau));
end