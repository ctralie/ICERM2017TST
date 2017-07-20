function [ DRet, perm, lambdas ] = getGreedyPermDM( D, NPoints )
% Purpose: Naive O(N^2) algorithm to do the greedy permutation (aka
% furthest point sampling)
%           :param D (NxN Distance Matrix)
%           :param NPoints (number of points in permutation)
%           :returns (D (resized distance matrix), perm (N-length array of indices), 
%                      lambdas (N-length array of insertion radii))
    if nargin < 2
        NPoints = size(D, 1);
    end
    perm = zeros(1, NPoints);
    perm(1) = 1;
    lambdas = zeros(1, NPoints);
    ds = D(1, :); %Distance of first point to all other points
    for ii = 2:NPoints
        [~, idx] = max(ds);
        perm(ii) = idx;
        lambdas(ii) = ds(idx);
        ds = min(ds, D(idx, :));
    end
    [perm, idx] = sort(perm);
    lambdas = lambdas(idx);
    DRet = D(perm, perm);
end

