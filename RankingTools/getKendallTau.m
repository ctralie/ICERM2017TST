function [ res ] = getKendallTau( order1, order2 )
    %Given two global rankings, return the Kendall Tau Score
    N = length(order1);
    rank1 = zeros(1, N);
    rank1(order1) = 1:N;
    rank2 = zeros(1, N);
    rank2(order2) = 1:N;
    A = sign(bsxfun(@minus, rank1, rank1'));
    B = sign(bsxfun(@minus, rank2, rank2'));
    res = sum(A(:).*B(:))/(N*(N-1));
end

