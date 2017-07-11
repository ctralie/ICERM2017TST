%Iterate increments on the circle
addpath('../GeometryTools');
addpath('../ripser');
dTheta = 0.2; %Increment between points
NTotal = 100; %Total number of points
AnimationSpeed = 2; %Number of frames per second
Animating = 1;

vals = zeros(NTotal, 1);

for ii = 2:NTotal
    vals(ii) = mod(vals(ii-1) + dTheta, 1);
    X = vals(1:ii);
    %First get pairwise absolute differences
    D = abs(bsxfun(@minus, X(:), X(:)'));
    %Then handle distances which are greater than 0.5, which should wrap
    %around
    D(D > 0.5) = 1 - D(D > 0.5);
    %Plot barcodes
    [Is] = ripserDM(D, 2, 1);
    I = Is{1}; %0D Diagram
    I = I(1:end-1, :); %Don't include essential class
    
    clf;
    subplot(121);
    stop = uicontrol('style','toggle','string','close', ...
      'units','norm','pos',[.14 .02 .10 .04],'value',0, ...
      'tag','stop','callback','cameratoolbar(''close''), close(gcf), Animating = 0;');

    %First plot points on circle
    subplot(121);
    t = linspace(0, 2*pi, 100);
    plot(cos(t)/(2*pi), sin(t)/(2*pi), 'b');
    hold on;
    x = cos(2*pi*vals)/(2*pi);
    y = sin(2*pi*vals)/(2*pi);
    scatter(x(1:ii), y(1:ii), 20, 'r', 'fill');
    scatter(x(ii), y(ii), 50, 'k', 'fill');
    axis equal;
    title(sprintf('Iteration %i', ii));
    
    %Now plot barcodes
    subplot(122);
    plotBarcodes(I);
    xlim([0, dTheta*1.5]);
    set(gca, 'YTickLabel', '');
    title('H0 Barcodes');
    
    pause(1/AnimationSpeed);
    if Animating == 0
        break;
    end
end