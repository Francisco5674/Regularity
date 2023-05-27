function x = BSvector(f, a, b)
vb = f(b);

[a,b] = adjust(vb,a,b);

m = (a+b)*0.5;
v = f(m);
% Tolerance to check convergence

while  norm(v)> 1*10^-5
    [a,b] = updt(v,a,b,m);
    m = (a+b)/2;
    v = f(m);
end
x = m;
end

