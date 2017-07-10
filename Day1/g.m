function [gret] = g(X)
    %TODO: Fill this in with your own function
    x = X(:, 1);
    y = X(:, 2);
    z = X(:, 3);
    %TODO: Fill in a function "gret" of your choosing.
    %For example, 
    gret = x + x.*y + z;
    %is the polynomial x + xy + z
end

