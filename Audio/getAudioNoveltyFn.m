function [novFn] = getAudioNoveltyFn(x, Fs, winSize, hopSize, maxFilt)
    %Using techniques from
    %Ellis, Daniel PW. "Beat tracking by dynamic programming." 
    %Journal of New Music Research 36.1 (2007): 51-60.
    if nargin < 5
        maxFilt = 0;
    end
    
    %First compute mel-spaced STFT
    S = STFT(x, winSize, hopSize);
    S = abs(S);
    M = getMelFilterbank(Fs, winSize, 40, 30, 8000);
    M = M(:, 1:size(S, 2));
    X = M*S';
    
    %[~, X, ~] = melfcc(x, Fs, 'winTime', 0.1, 'hopTime', hopTime, 'numcep', 20);
    if maxFilt
        X = ordfilt2(X, 3, ones(3, 1));
    end
    novFn = X(:, 2:end) - X(:, 1:end-1);
    novFn(novFn < 0) = 0;
    novFn = sum(novFn, 1);
end
