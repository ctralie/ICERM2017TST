%A function to split up rankings of videos
%Assuming 20 videos, 19 students
function [ R ] = makePairwiseVideoComparisons( num )
    N = 20;
    rng(N);
    [I, J] = meshgrid(1:N, 1:N);
    I = I - diag(1:N) - 1;
    J = J - diag(1:N) - 1;
    I = nonzeros(triu(I));
    J = nonzeros(triu(J));
    R = zeros(length(I), 3);
    R(:, 1) = I;
    R(:, 2) = J;
    perm = randperm(length(I));
    R = R(perm, :);
    R = R((num-1)*10 + (1:10), :);
    for ii = 1:size(R, 1)
        R(ii, 3) = compareVideoPair(R(ii, 1), R(ii, 2));
    end
end

