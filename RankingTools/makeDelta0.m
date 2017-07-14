function [ Delta0 ] = makeDelta0( R )
% Return the delta0 coboundary matrix
%     :param R: NEdges x 2 matrix specifying edges, where orientation
%     is taken from the first column to the second column
%     R should specify the "natural orientation" of the edges, with the
%     understanding that the ranking will be specified later
%     It is assumed that there is at least one edge incident
%     on every vertex
    NVertices = max(R(:));
    NEdges = size(R, 1);
    
    %Two entries per edge
    I = zeros(NEdges, 2);
    I(:, 1) = 1:NEdges;
    I(:, 2) = 1:NEdges;
    I = I(:);
    J = R(:);
    
    V = zeros(NEdges, 2);
    V(:, 1) = -1;
    V(:, 2) = 1;
    V = V(:);
    
    
    Delta0 = sparse(I, J, V, NEdges, NVertices);
end

