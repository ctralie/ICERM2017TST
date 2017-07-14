function [ Delta1 ] = makeDelta1( R )
%Make the delta1 coboundary matrix
    %:param R: Edge list NEdges x 2. It is assumed that 
    %there is at least one edge incident on every vertex
    NVertices = max(R(:));
    NEdges = size(R, 1);
    %Make an adjacency matrix and edge indexing matrix
    I = [R(:, 1); R(:, 2)];
    J = [R(:, 2); R(:, 1)];
    V = ones(size(I));
    A = sparse(I, J, V, NVertices, NVertices); %Adjacency matrix
    E = sparse(I, J, [1:size(R, 1)' 1:size(R, 1)]); %Edge indexing matrix
    
    tic;
    disp('Getting 3 cliques...');
    [I, J, V] = get3Cliques(A, E);
    toc;
    I = I(:); J = J(:); V = V(:);
    TriNum = length(I)/3;
    Delta1 = sparse(I, J, V, TriNum, NEdges);
end

