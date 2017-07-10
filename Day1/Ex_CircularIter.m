%Iterate increments on the circle
addpath('../GeometryTools');
addpath('../ripser');
dTheta = 0.5; %Increment between points
NTotal = 100; %Total number of points
AnimationSpeed = 2; %Number of frames per second

vals = zeros(NTotal, 1);

for ii = 2:NTotal
    vals(ii) = mod(vals(ii-1) + dTheta, 2*pi);
    X = vals(1:ii);
    %First get pairwise absolute differences
    D = abs(bsxfun(@minus, X(:), X(:)'));
    %Then handle distances which are greater than pi, which should wrap
    %around
    D(D > pi) = 2*pi - D(D > pi);
    %Plot barcodes
    [Is] = ripserDM(D, 2, 1);
    I = Is{1}; %0D Diagram
    I = I(1:end-1, :); %Don't include essential class
    clf;
    %First plot points on circle
    subplot(121);
    t = linspace(0, 2*pi, 100);
    plot(cos(t), sin(t), 'b');
    hold on;
    x = cos(vals);
    y = sin(vals);
    scatter(x, y, 20, 'r', 'fill');
    axis equal;
    
    %Now plot barcodes
    subplot(122);
    plotBarcodes(I);
    xlim([0, dTheta*1.5]);
    set(gca, 'YTickLabel', '');
    
    pause(1/AnimationSpeed);
end