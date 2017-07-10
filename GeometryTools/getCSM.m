function [ D ] = getCSM( X, Y )
    dotX = dot(X, X, 2);
    dotY = dot(Y, Y, 2);
    D = bsxfun(@plus, dotX, dotY') - 2*(X*Y');
end

