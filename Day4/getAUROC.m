function [ res ] = getAUROC( FP, TP )
    FP = FP(:)';
    TP = TP(:)';
    res = sum(abs((FP(2:end)-FP(1:end-1)).*TP(2:end)));
end

