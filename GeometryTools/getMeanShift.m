function [ Y ] = getMeanShift( X, theta )
    % Programmer: Chris Tralie
    % Purpose: Given a N x d matrix representing a d-dimensional point
    % cloud, assumed to be normalized to the sphere, perform
    % mean shift using points in a neighborhood theta
    if nargin < 2
        theta = pi/16;
    end
    N = size(X, 1);
    thresh = cos(theta);
    XS = bsxfun(@times, X, 1./sqrt(sum(X.^2, 2)));
    D = XS*XS';
    [J, I] = meshgrid(1:N, 1:N);
    J = J(D >= thresh);
    I = I(D >= thresh);
    V = ones(size(I));
    D = sparse(I, J, V, N, N);
    idx = 1:N;
    Y = 0*X;
    for ii = 1:N
        thisidx = idx(D(ii, :) > 0);
        Y(ii, :) = mean(X(thisidx, :), 1);
    end
end

