function [ Y, perm, lambdas ] = getGreedyPerm( X, NPoints )
% Purpose: Naive O(N^2) algorithm to do the greedy permutation (aka
% furthest point sampling)
%           :param X (Nxd point cloud)
%           :param NPoints (number of points in permutation)
%           :returns (Y (greedy permutation), perm (N-length array of indices), 
%                      lambdas (N-length array of insertion radii))
    if nargin < 2
        NPoints = size(X, 1);
    end
    perm = zeros(1, NPoints);
    perm(1) = 1;
    lambdas = zeros(1, NPoints);
    ds = pdist2(X(1, :), X);
    for ii = 2:NPoints
        [~, idx] = max(ds);
        perm(ii) = idx;
        lambdas(ii) = ds(idx);
        ds = min(ds, pdist2(X(idx, :), X));
    end
    Y = X(perm, :);
end

