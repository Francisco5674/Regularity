%% Example

tau_ex=0.75;
c_ex=90;
h_ex=0.8;
l_ex=0.3;


dom = linspace(0.001,1-tau_ex,I);
dom = dom(1:I-1);
L = BSvector(@(u) f(u,dom, ...
    h_ex, ...
    l_ex, ...
    c_ex, ...
    tau_ex),a,b);

[dom,diver,ar,br,udiver] = ...
    precheck(@(u) lic(u,dom,l_ex,c_ex,tau_ex),a,b,dom);

D = BSvector(@(u) lic(u,dom, ...
    l_ex, ...
    c_ex, ...
    tau_ex),ar,br);

dom = [dom, diver];
D = [D, udiver];

[intercept, ind] = min(abs(D - L));

plot(dom,L, dom, D)
title("Example")
xlabel('k') 
ylabel('Mu') 
