%Inputs: 
%S: A Nx2 array of persistence points for the first diagram
%T: A Mx2 array of persistence points for the second diagram
function [ bdist, idx ] = getBottleneckDist( S, T )
    N = size(S, 1);
    M = size(T, 1);
    
    dotS = dot(S, S, 2);
    dotT = dot(T, T, 2);
    DUL = bsxfun(@plus, dotS, dotT') - 2*(S*T');
    DUL(DUL < 0) = 0;
    DUL = sqrt(DUL);
    
    %Put diagonal elements into the matrix
    %Rotate the diagrams to make it easy to find the straight line
    %distance to the diagonal
    R = [cos(pi/4) -sin(pi/4); sin(pi/4) cos(pi/4)];
    SR = S*R;
    TR = T*R;
    D = zeros(N+M, N+M);
    D(1:N, 1:M) = DUL;
    UR = max(D(:))*ones(N, N);
    UR(1:N+1:end) = SR(:, 2);
    D(1:N, M+1:end) = UR;
    UL = max(D(:))*ones(M, M);
    UL(1:M+1:end) = TR(:, 2);
    D(N+1:end, 1:M) = UL;
    
    %TODO: Slow linear search right now, 
    %Change to a binary search on the unique distances
    ds = sort(unique(D(:)));
    ds = ds(2:end); %Ignore 0 distance
    [J, I] = meshgrid(1:size(D, 2), 1:size(D, 1));
    for idx = 1:length(ds)
        A = (D <= ds(idx));
        rows = I(A == 1);
        cols = J(A == 1);
        R = ones(length(rows), 3);
        R(:, 1) = rows;
        R(:, 2) = cols + size(D, 1);
        outmate = maxWeightMatching(R);
        if (sum(outmate == -1) == 0)
        	break;
        end
    end
    bdist = ds(idx);
    J = J(D == bdist);
    I = I(D == bdist);
    idx = [I(:) J(:)];
end
