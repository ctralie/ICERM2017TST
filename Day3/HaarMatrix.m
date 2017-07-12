function [ H ] = HaarMatrix( M )
    %Return a normalized Haar matrix with M wavelets
    %This assumes M is a power of 2
    H2 = [1 1; 1 -1];
    H = H2;
    m = 2;
    while m < M
        H = [kron(H, [1, 1]); kron(eye(m), [1, -1])];
        m = m * 2;
    end
    HNorms = sqrt(sum(H.^2, 2));
    H = bsxfun(@times, H, 1./HNorms(:));
end

