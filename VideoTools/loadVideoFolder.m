function [ V, VDims ] = loadVideoFolder( foldername, fileext, newdims )
    if nargin < 2
        fileext = 'png';
    end
    files = dir([foldername, filesep, '*.', fileext]);
    N = length(files);
    V = cell(1, N);
    for ii = 1:N
        v = single(imread(sprintf('%s/%i.%s', foldername, ii, fileext)))/255.0;
        if nargin > 2
            v = imresize(v, newdims);
        end
        VDims = size(v);
        V{ii} = v(:);
    end
    V = cell2mat(V)';
end

