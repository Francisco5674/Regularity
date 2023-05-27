function [conv, diver, aconv, bconv, soldiver] = precheck(f,a,b,k)

fa = f(a);
fb = f(b);

fact = fa.*fb < 0;
conv = [];
diver = [];
aconv = [];
bconv = [];
soldiver = [];
% if any value of f() has a constant sign between a and b, 
% then the bisection algorithm is useless
for i=1:size(k,2)

    % This loop checks for these cases, and makes the algortihm useful
    % again

    if fact(i) == 1
        conv = [conv, k(i)];
        aconv = [aconv, a(i)];
        bconv = [bconv, b(i)];

    elseif fact(i) == 0
        if abs(fa(i)) >= abs(fb(i))
            soldiver = [soldiver, b(i)];
        
        else
            soldiver = [soldiver, a(i)];
        end
        diver = [diver, k(i)];
    end
    
end
end
