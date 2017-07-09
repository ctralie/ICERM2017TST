function [gret] = g(X)
    x = X(:, 1);
    y = X(:, 2);
    z = X(:, 3);
    %TODO: Fill in a function "gret" of your choosing.
    %For example, 
    gret = x + y.^3 + z.^5;
    %is the polynomial x + y^3 + z^5
end

