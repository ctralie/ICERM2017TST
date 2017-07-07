function [ X ] = getSlidingWindow( x, dim, Tau, dT )
% A function that computes the sliding window embedding of a
% discrete signal.  If the requested windows and samples do not
% coincide with samples in the original signal, spline interpolation
% is used to fill in intermediate values
%     :param x: The discrete signal
%     :param dim: The dimension of the sliding window embedding
%     :param Tau: The increment between samples in the sliding window 
%     :param dT: The hop size between windows
%     :returns: An Nxdim Euclidean vector of sliding windows
    N = length(x);
    NWindows = floor((N-dim*Tau)/dT);
    X = zeros(NWindows, dim);
    idx = 1:N;
    for ii = 1:NWindows
        idxx = 1 + dT*(ii-1) + Tau*(0:dim-1);
        istart = floor(idxx(1));
        iend = ceil(idxx(end))+2;
        if iend >= N
            X = X(1:ii-1, :);
            break;
        end
        X(ii, :) = spline(idx(istart:iend), x(istart:iend), idxx);
    end
end

