function [ H ] = FourierMatrix( N )
    %Return a normalized Discrete Fourier matrix with N elements
    %This assumes N is odd
    k = 1:(N-1)/2;
    n = 1:N;
    H = ones(N, N);
    [NN, KK] = meshgrid(n, k);
    H(2:2:end, :) = cos(2*pi*NN.*KK/N);
    H(3:2:end, :) = sin(2*pi*NN.*KK/N);
    HNorms = sqrt(sum(H.^2, 2));
    H = bsxfun(@times, H, 1./HNorms(:));
end

