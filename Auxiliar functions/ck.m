function r = ck(A,p,l,k)
r = A.*p.*k.^(p-1) + (1-l)*0.5;
end