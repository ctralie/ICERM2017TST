function [ X ] = getSlidingWindowVideo( V, dim, Tau, dT )
% A function that computes the sliding window embedding of a
% video sequence.  If the requested windows and samples do not
% coincide with samples in the original signal, pixel by pixel
% linear interpolation is used to fill in intermediate values
%     :param V: An N x d array of N d-pixel frames
%     :param dim: The dimension of the sliding window embedding
%     :param Tau: The increment between samples in the sliding window 
%     :param dT: The hop size between windows
%     :returns: An Nx(dxdim) Euclidean vector of sliding windows
    N = size(V, 1); %Number of frames
    P = size(V, 2); %Number of pixels
    pix = 1:P;
    NWindows = floor((N-dim*Tau)/dT);
    X = zeros(NWindows, dim*P);
    for ii = 1:NWindows
        idxx = 1 + dT*(ii-1) + Tau*(0:dim-1);
        istart = floor(idxx(1));
        iend = ceil(idxx(end))+2;
        if iend >= N
            X = X(1:ii-1, :);
            break;
        end
        v = V(istart:iend, :);
        [x, y] = meshgrid(pix, istart:iend);
        [xq, yq] = meshgrid(pix, idxx);
        vq = interp2(x, y, v, xq, yq);
        X(ii, :) = vq(:);
        %f = scipy.interpolate.interp2d(pix, idx[start:end+1], I[idx[start:end+1], :], kind='linear')
        %X[i, :] = f(pix, idxx).flatten()
    end

end

