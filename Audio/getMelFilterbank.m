function [ melfbank ] = getMelFilterbank( Fs, winSize, nbands, minfreq, maxfreq )
    %Programmer: Chris Tralie
    %Purpose: Return a mel-spaced triangle filterbank
    %Step 1: Warp to the mel-frequency scale
    melbounds = [minfreq, maxfreq];
    melbounds = 1125*log(1 + melbounds/700.0);
    mel = linspace(melbounds(1), melbounds(2), nbands);
    binfreqs = 700*(exp(mel/1125.0) - 1);
    binbins = ceil(((winSize-1)/Fs)*binfreqs); %Ceil to the nearest bin

    %Step 2: Create mel triangular filterbank
    melfbank = zeros(nbands, winSize);
    for ii = 1:nbands
       thisbin = binbins(ii);
       lbin = thisbin;
       if ii > 1
           lbin = binbins(ii-1);
       end
       rbin = thisbin + (thisbin - lbin);
       if ii < nbands
           rbin = binbins(ii+1);
       end
       melfbank(ii, lbin:thisbin) = linspace(0, 1, 1 + (thisbin - lbin));
       melfbank(ii, thisbin:rbin) = linspace(1, 0, 1 + (rbin - thisbin));
   end

end

