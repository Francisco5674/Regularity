function y = g(u,k,h,l,tau,p,A)
y = ((ck(A,p,l,k) - vk(u,k,h,tau)).*vu(u,k,l,tau))-...
    ((ck(A,p,l,k) - vk(u,k,l,tau)).*vu(u,k,h,tau));
end