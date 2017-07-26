function [ dist ] = getBottleneckDist( S, T )
    dlmwrite('PD1.txt', S, ' ');
    dlmwrite('PD2.txt', T, ' ');
    cmdout = '-1';
    if isunix && ~ismac
        [~, cmdout] = system('./bottleneck_dist_unix PD1.txt PD2.txt 0.0');
    elseif ismac
        [~, cmdout] = system('./bottleneck_dist_mac PD1.txt PD2.txt 0.0');
    else
        disp('Error: Your operating system is not supported yet');
    end
    res = strsplit(cmdout, '\n')
    dist = str2double(res(end-1));
end

