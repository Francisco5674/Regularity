%% Testing BSvectorial adjustment 

v = [-1,2,32,-2,-10,9];
a = repmat(0.01,1,6);
b = ones(1,6);
m = repmat(0.5,1,6);
c = [0.9,0.8,0.7,0.6,0.5,0.4];

%% Testing BS

sol = BSvector(@(x) test(x,c),b,a);

%% Function to test

function y = test(x,c)
y = (x.^2 - c).*(-1).^(10*c);
end