function [I, J, V] = get3Cliques(A, E)
    %Brute force method to find all 3 cliques from a list of edges
    NVertices = size(A, 1);
    MaxNum = NVertices*(NVertices-1)*(NVertices-2)/6;
    J = zeros(MaxNum, 3);
    MC = maximalCliques(A);
    edgeNum = 1;
    for col = 1:size(MC, 2)
        idx = 1:NVertices;
        idx = idx(MC(:, col) > 0);
        if length(idx) >= 3
            %Add all 3 cliques
            for ii = 1:length(idx)
                for jj = ii+1:length(idx)
                    for kk = jj+1:length(idx)
                        J(edgeNum, :) = [E(ii, jj), E(ii, kk), E(kk, jj)];
                        edgeNum = edgeNum+1;
                    end
                end
            end
        end
    end
    J = J(1:edgeNum-1, :);
    V = zeros(size(J));
    V(:, 1) = 1;
    V(:, 2) = -1;
    V(:, 3) = 1;
    I = zeros(size(J));
    for kk = 1:3
        I(:, kk) = 1:size(I, 1);
    end
end

