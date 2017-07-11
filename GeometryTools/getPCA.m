function [Y] = getPCA( X )
    % Programmer: Chris Tralie
    % Purpose: Perform PCA on a Euclidean point cloud, where 
    % each point is its on row
    Cov = X'*X;
    [V, ~] = eig(Cov);
    Y = X*V;
    Y = fliplr(Y); %eig returns smallest eigenvalues first
end