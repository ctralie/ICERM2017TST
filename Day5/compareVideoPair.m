function [ res ] = compareVideoPair( i1, i2 )
    s = fileread('template.html');
    s = strrep(s, 'video1', sprintf('%i', i1));
    s = strrep(s, 'video2', sprintf('%i', i2));
    fout = fopen('pair.html', 'w');
    fprintf(fout, '%s', s);
    fclose(fout);
    web('pair.html');
    res = input('Which Video Is More Periodic (1/2)?: ');
end

