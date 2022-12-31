function [A, B] = adjust(valuesb,a,b)

positive = valuesb>0;
negative = 1- positive;

A = a.*positive + negative.*b;
B = a.*negative + positive.*b;
end


