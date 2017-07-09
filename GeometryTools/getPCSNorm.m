function [ XS ] = getPCSNorm( X )
    % Return the point-centered, sphere-normalized version of X
    XS = bsxfun(@minus, X, mean(X, 2));
    n = sqrt(sum(XS.^2, 2));
    XS = bsxfun(@times, XS, 1./n(:));
end

