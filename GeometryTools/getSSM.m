function [ D ] = getSSM( X )
    dotX = dot(X, X, 2);
    D = bsxfun(@plus, dotX, dotX') - 2*(X*X');
    D = 0.5*(D + D');
    D(D < 0) = 0;
    D = sqrt(D);
    D = D - diag(diag(D));
end

