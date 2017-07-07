function [Y] = getTimeDerivative( X, window )
    %Approximate a smoothed derivative in time of each
    %coordinate in X, where the time axis is down the rows
    dw = round(window/2);
    t = -dw:dw;
    sigma = 0.4*dw;
    xgaussf = -t.*exp(-t.*t ./ (2*sigma^2));
    %Normalize by L1 norm to control for length of window
    xgaussf = xgaussf/sum(abs(xgaussf));
    Y = conv2(X, xgaussf(:), 'valid')';
end

