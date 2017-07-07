function [ X ] = getSlidingWindowInteger( x, dim, Tau, dT )
% A function that computes the sliding window embedding of a
% discrete signal.  Tau and dT are integers, so only samples from
% the original signal are taken.
%     :param x: The discrete signal
%     :param dim: The dimension of the sliding window embedding
%     :param Tau: The increment between samples in the sliding window 
%     :param dT: The hop size between windows
%     :returns: An Nxdim Euclidean vector of sliding windows
    N = length(x);
    NWindows = floor((N-dim*Tau)/dT);
    if NWindows <= 0
        disp('Error: Tau too large for signal extent');
        return;
    end
    X = zeros(NWindows, dim);
    for ii = 1:NWindows
        idxx = 1 + dT*(ii-1) + Tau*(0:dim-1);
        X(ii, :) = x(idxx);
    end
end

