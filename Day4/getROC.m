function [ FP, TP ] = getROC( T, F )
    values = sort([T(:); F(:)]); %All intervals
    N = length(values);
    FP = zeros(N, 1); %False positives
    TP = zeros(N, 1); %True positives
    for ii = 1:N
        FP(ii) = sum(F >= values(ii))/length(F);
        TP(ii) = sum(T >= values(ii))/length(T);
    end
end

