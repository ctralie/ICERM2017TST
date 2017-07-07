function [ V, VDims ] = loadVideo( filename, doRGBNTSC )
    obj = VideoReader(filename);
    N = obj.NumberOfFrames;
    V = cell(1, N);
    for ii = 1:N
        v = single(read(obj, ii))/255.0;
        if nargin > 1
            if doRGBNTSC
                v = rgb2ntsc(v);
            end
        end
        VDimsOrig = size(v);
        VDims = size(v);
        V{ii} = v(:);
    end
    V = cell2mat(V)';
end

