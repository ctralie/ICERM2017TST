function [ y ] = getRandomPhaseShift( x )
    idx = randi(length(x));
    x = x(:);
    y = [x(idx:end); x(1:idx-1)];
end

