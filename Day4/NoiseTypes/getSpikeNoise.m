function [ y ] = getSpikeNoise( x, p )
    %Put impulsive noise in x.  p is the probability that any given
    %sample is corrupted by impulsive noise, whose magnitude is 
    %normally distributed with standard deviation equal to the standard
    %deviation of the signal
    N = length(x);
    s = std(x);
    ps = rand(N, 1);
    y = x(:) + s*randn(N, 1).*(ps < p);
end

