function [A, B] = updt(v,a,b,m)

positive = v>0;
negative = 1- positive;

A = a.*positive + negative.*m;
B = b.*negative + positive.*m;
end

