function [ X ] = getSlidingWindowNoInterp( x, dim)
% A function that computes the sliding window embedding of a
% discrete signal.  It is assumed that Tau = 1 and dT = 1.
% This function is faster than getSlidingWindow() in this case
%     :param x: The discrete signal
%     :param dim: The dimension of the sliding window embedding
%     :returns: An Nxdim Euclidean vector of sliding windows
    
    N = length(x);
    NWindows = N - dim + 1;
    X = zeros(NWindows, dim);
    idx = 1:N;
    for ii = 1:NWindows
        X(ii, :) = x(ii:ii+dim-1);
    end
end

