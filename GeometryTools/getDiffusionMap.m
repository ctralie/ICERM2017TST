function [X] = getDiffusionMap(D, K, NEigs, t)
% Programmer: Chris Tralie
% Purpose: Given a distance matrix, perform diffusion maps
%   :param D: NxN distance matrix
%   :param K: Number of nearest neighbors to use
%   :param NEigs: Number of eigenvectors to use (default max(51, N))
%   :param t: Diffusion time.  By default -1 (autotuned)
%   :param X: An N x NEigs-1 vector of diffusion coordinates
    if nargin < 3
        NEigs = 51;
    end
    if nargin < 4
        t = -1;
    end
    
    %Step 1: Calculate Kernel
    N = size(D, 1);
    D2 = sort(D + max(D(:))*eye(N), 2);
    MeanDist = mean(D2(:, 1:K), 2);
    Eps = bsxfun(@plus, MeanDist(:), MeanDist(:)');
    Eps = (Eps + D)/3.0;
    W = exp(-D.^2./(2*(0.5*Eps).^2));
    
    %Symmetric Normalized Laplacian
    RowSumSqrt = sqrt(sum(W, 2));
    Pp = bsxfun(@times, W, 1./RowSumSqrt(:)');
    Pp = bsxfun(@times, Pp, 1./RowSumSqrt(:));
    
    %Get eigenvectors
    NEigs = min(NEigs, N-1);
    [V, ev] = eigs(Pp, NEigs);
    ev = diag(ev);
    ev = ev/ev(1);
    
    if t == -1
        %Autotune diffusion time
        lamt = ev;
        lamt(1:end-1) = ev(1:end-1)./(1-ev(1:end-1));
    else
        lamt = ev.^t;
    end
        
    X = bsxfun(@times, V, lamt(:)');
    X = X(:, 2:end);
end
