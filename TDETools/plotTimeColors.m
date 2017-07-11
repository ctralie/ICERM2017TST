function [C] = plotTimeColors(t, X, varargin)
    % Plot a time series or time-ordered point cloud with colors
    type = '2DLine';
    lw = 2;
    for ii = 1:2:length(varargin)
        if strcmp(varargin{ii}, 'type')
            type = varargin{ii+1};
        end
        if strcmp(varargin{ii}, 'LineWidth')
            lw = varargin{ii+1};
        end
    end
    
    %Setup ROYGBIV colors
    c = load('spectral.mat');
    c = c.c;
    [x, y] = meshgrid(1:size(c, 2), 1:size(c, 1));
    tidx = t - min(t(:));
    tidx = tidx/max(tidx(:));
    tidx = 1 + tidx*254;
    [xq, yq] = meshgrid(1:size(c, 2), tidx);
    C = interp2(x, y, c, xq, yq);
    
   % scatter3(X(:, 1), X(:, 2), X(:, 3), 20, C(:, 1:3), 'fill');
    
    if strcmp(type, '2DLine')
        C = uint8(255*C);
        hold on;
        for ii = 1:length(t)-1
            plot([t(ii), t(ii+1)], [X(ii), X(ii+1)], 'color', C(ii, :), 'LineWidth', lw);
        end
    elseif strcmp(type, '3DLine')
        C = uint8(255*C);
        hold on;
        for ii = 1:length(t)-1
            plot3([X(ii, 1), X(ii+1, 1)], [X(ii, 2), X(ii+1, 2)], [X(ii, 2), X(ii+1, 2)], 'color', C(ii, :), 'LineWidth', lw);
        end
    elseif strcmp(type, '2DPC')
        scatter(t, X, 20, C(:, 1:3), 'fill');
    elseif strcmp(type, '3DPC')
        scatter3(X(:, 1), X(:, 2), X(:, 3), 20, C(:, 1:3), 'fill');
    else
        disp('Unknown plot type for color plot');
    end        
end