function [ S ] = STFT( X, W, H, winfunc )
    %Programmer: Chris Tralie
    %A function to compute the short-time fourier transform of a signal
    %X: N x 1 Audio Signal, W: Window Size: H HopSize, winfunc: Window
    Q = W/H;
    if Q - floor(Q) > 0
        fprintf(1, 'Warning: Window size is not integer multiple of hop size\n');
    end
    if nargin < 4
        %Use half sine by default
        winfunc = @(W) sin(pi*(0:W-1)/(W-1));
    end
    win = winfunc(W);
    NWin = floor((length(X) - W)/H) + 1;
    S = zeros(NWin, W);
    for ii = 1:NWin
        x = X((1:W) + (ii-1)*H);
        S(ii, :) = fft( win(:).*x(:) );
    end
    %Second half of the spectrum is redundant for real signals
    if mod(W, 2) == 0
        %Even Case
        S = S(:, 1:W/2+1);
    else
        %Odd Case
        S = S(:, 1:(W-1)/2+1);
    end
end

