function [ s ] = doHodge( R, W, Y, verbose )
%Given 
    %:param R: NEdges x 2 matrix specfiying comparisons that have been made
    %:param W: A flat array of NEdges weights parallel to the rows of R
    %:param Y: A flat array of NEdges specifying preferences
    %:returns: (s, I, H): s is scalar function, I is local inconsistency vector,
    %    H is global inconsistency vector
    if nargin < 4
        verbose = 0;
    end

    %Step 1: Get s
    if verbose
        disp('Making Delta0...');
        tic;
    end
    D0 = makeDelta0(R);
    if verbose
        toc;
    end
    wSqrt = sqrt(W(:));
    N = length(wSqrt);
    WSqrt = sparse(1:N, 1:N, wSqrt, N, N);
    WSqrtRecip = sparse(1:N, 1:N, 1./wSqrt, N, N);
    A = WSqrt*D0;
    b = WSqrt*Y;
    s = lsqr(A, b);
    
%     #Step 2: Get local inconsistencies
%     if verbose:
%         print "Making Delta1..."
%     tic = time.time()
%     D1 = makeDelta1(R)
%     toc = time.time()
%     if verbose:
%         print "Elapsed Time: ", toc-tic, " seconds"
%     B = WSqrtRecip*D1.T
%     resid = Y - D0.dot(s)  #This has been verified to be orthogonal under <resid, D0*s>_W
%     
%     u = wSqrt*resid
%     if verbose:
%         print "Solving for Phi..."
%     tic = time.time()
%     Phi = lsqr(B, u)[0]
%     toc = time.time()
%     if verbose:
%         print "Elapsed Time: ", toc - tic, " seconds"
%     I = WSqrtRecip.dot(B.dot(Phi)) #Delta1* dot Phi, since Delta1* = (1/W) Delta1^T
%     
%     #Step 3: Get harmonic cocycle
%     H = resid - I
%     return (s, I, H)

end

