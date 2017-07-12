function [ y ] = getAWGN( x, level )
    s = std(x);
    y = x + s*level*randn(size(x));
end

