function [] = saveVideo( V, VDims, filename, FrameRate, doRGBNTSC )
    writerObj = VideoWriter(filename);
    if nargin > 3
        writerObj.FrameRate = FrameRate;
    end
    open(writerObj);
    for ii = 1:size(V, 2)
        v = reshape(V(:, ii), VDims);
        if nargin > 4
            if doRGBNTSC
                v = ntsc2rgb(v);
            end
        end
        v = min(v, 1);
        v = max(v, 0);
        writeVideo(writerObj, v);
    end
    close(writerObj);
end

