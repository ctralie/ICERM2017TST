function [y] = getRandomReparam( x, fac )
    N = length(x);
    t = rand(round(N/fac), 1);
    t = cumsum(t);
    t = t/max(t);
    t = interp1(linspace(0, 1, length(t)), t, linspace(0, 1, N));
    y = interp1(linspace(0, 1, length(t)), x, t);
end

