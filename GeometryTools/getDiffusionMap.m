function [X, W, Pp] = getDiffusionMap(D, K, NEigs)
    if nargin < 3
        NEigs = 51;
    end
    N = size(D, 1);
    NEigs = min(NEigs, N-1);
    
    %Step 1: Calculate Kernel
    D2 = sort(D + max(D(:))*eye(N), 2);
    MeanDist = mean(D2(:, 1:K), 2);
    Eps = bsxfun(@plus, MeanDist(:), MeanDist(:)');
    Eps = (Eps + D)/3.0;
    W = exp(-D.^2./(2*(0.5*Eps).^2));
    
    RowSumSqrt = sqrt(sum(W, 2));
    
    %Symmetric Normalized Laplacian
    Pp = bsxfun(@times, W, 1./RowSumSqrt(:)');
    Pp = bsxfun(@times, Pp, 1./RowSumSqrt(:));
    [V, ev] = eig(Pp);
    V = fliplr(V);
    ev = diag(ev);
    ev = fliplr(ev(:)');
    
    %Autotune diffusion time
    lamt = ev;
    lamt(1:end-1) = ev(1:end-1)./(1-ev(1:end-1));
    
    X = bsxfun(@times, V, lamt(:)');
    X = fliplr(X);
end