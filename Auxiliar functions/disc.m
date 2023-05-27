function [mudisc] = disc(mu)
% this function discretizes a vector between 0 and 1
mudisc = [];

for i = 1:length(mu)
    u = mu(i);
    if (0.95 < u) && (u <= 1)
        mudisc = [mudisc, "(.95, 1]"];
    elseif (0.9 < u) && (u <= 0.95)
        mudisc = [mudisc, "(.9, .95]"];
    elseif (0.85 < u) && (u <= 0.9)
        mudisc = [mudisc, "(.85, .9]"];
    elseif (0.8 < u) && (u <= 0.85)
        mudisc = [mudisc, "(.8, .85]"];
    elseif (0.75 < u) && (u <= 0.8)
        mudisc = [mudisc, "(.75, .8]"];
    elseif (0.7 < u) && (u <= 0.75)
        mudisc = [mudisc, "(.7, .75]"];
    elseif (0.6 < u) && (u <= 0.7)
        mudisc = [mudisc, "(.6, .7]"];
    elseif (0.5 < u) && (u <= 0.6)
        mudisc = [mudisc, "(.5, .6]"];
    elseif (0.4 < u) && (u <= 0.5)
        mudisc = [mudisc, "(.4, .5]"];
    elseif (0.3 < u) && (u <= 0.4)
        mudisc = [mudisc, "(.3, .4]"];
    elseif (0.2 < u) && (u <= 0.3)
        mudisc = [mudisc, "(.2, .3]"];
    elseif (0.1 < u) && (u <= 0.2)
        mudisc = [mudisc, "(.1, .2]"];
    elseif (0 < u) && (u <= 0.1)
        mudisc = [mudisc, "(0, .1]"];
    end
end

end

