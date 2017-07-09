function [ XS ] = getZNorm( X )
    % Z-normalize each point in the N x d point cloud X
    XS = bsxfun(@minus, X, mean(X, 1));
    n = sqrt(sum(XS.^2, 2));
    XS = bsxfun(@times, XS, 1./n(:));
end

