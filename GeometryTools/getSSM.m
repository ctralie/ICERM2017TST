function [ D ] = getSSM( X )
    dotX = dot(X, X, 2);
    D = bsxfun(@plus, dotX, dotX') - 2*(X*X');
end

