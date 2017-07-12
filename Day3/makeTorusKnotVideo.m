SamplesPerPeriod = 60;
NPeriods = 3;
N = NPeriods*SamplesPerPeriod;
t = linspace(0, NPeriods*2*pi, N);
y = cos(t) + 2*cos(2*t);
r = max(abs(y))*1.5;

for ii = 1:SamplesPerPeriod*NPeriods
    clf;
    subplot(121);
    plot(y(1:ii));
    xlim([1, N]);
    ylim([-2.5, 3.5]);
    subplot(122);
    drawMoebiusTorus(2*t(1:ii), 1, 0, -26, 35, ii);
    fig = gcf;
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0 0 14 5];
    print('-dpng', '-r100', sprintf('Disc%i.png', ii));
end