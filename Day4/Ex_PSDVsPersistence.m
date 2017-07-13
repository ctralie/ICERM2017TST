%Purpose: To show the difference between cos(t) + cos(3*t) from the 
%perspective of traditional power spectral density estimations versus
%sliding window persistence
%Plots of persistence diagrams have blue for H1 and red for H2
addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

dim = 30;
Tau = 1;
dT = 1;

T1 = 10; %The period of the first sine in number of samples
NPeriods = 15; %How many periods to go through, relative to the second sinusoid
N = T1*3*NPeriods; %The total number of samples
t = (1:N)*2/sqrt(5); %Time indices

%Step 1: Setup the signal cos(t) + cos(3t)
T2 = T1*3; %The period of the second sine in number of samples
fh = cos(2*pi*(1.0/T1)*t); %The first sinusoid
fh = fh + cos(2*pi*(1.0/T2)*t); %The second sinusoid
fh = fh + 0.05*randn(1, length(fh));
XH = getSlidingWindow(fh, dim, Tau, dT);
XH = getPCSNorm(XH);
disp('Getting persistence of fh...');
Is = ripserPC(XH, 41, 2);
H11 = Is{2};
H21 = Is{3};
YH = getPCA(XH);
PH = log10(abs(fft(fh)).^2); %Power spectral density
PH = PH(1:ceil(length(PH)/2));



%Step 2: Setup the signal cos(t) + cos(pi*t)
T2 = T1*pi; %The period of the second sine in number of samples
fq = cos(2*pi*(1.0/T1)*t); %The first sinusoid
fq = fq + cos(2*pi*(1.0/T2)*t); %The second sinusoid
fq = fq + 0.05*randn(1, length(fh));
XQ = getSlidingWindow(fq, dim, Tau, dT);
XQ = getPCSNorm(XQ);
disp('Getting persistence of fq...');
Is = ripserPC(XQ, 41, 2);
H12 = Is{2};
H22 = Is{3};
YQ = getPCA(XQ);
PQ = log10(abs(fft(fq)).^2); %Power Spectral Density
PQ = PQ(1:ceil(length(PQ)/2));

%Plot all of the results
figure(1);
clf;
subplot(231);
C = plotTimeColors(t, fh);
ylim([-3, 3]);
title('fh = cos(t) + cos(3t)');
subplot(232);
scatter3(YH(:, 1), YH(:, 2), YH(:, 3), 20, C(1:size(YH, 1), 1:3), 'fill');
title('PCA');
subplot(233);
plotDGM(H11, 'b');
title('Persistence Diagrams');
hold on;
plotDGM(H21, 'r');

subplot(234);
C = plotTimeColors(t, fq);
ylim([-3, 3]);
title('fq = cos(t) + cos(pi*t)');
subplot(235);
scatter3(YQ(:, 1), YQ(:, 2), YQ(:, 3), 20, C(1:size(YQ, 1), 1:3), 'fill');
title('PCA');
subplot(236);
plotDGM(H12, 'b');
title('Persistence Diagrams');
hold on;
plotDGM(H22, 'r');
set(gcf, 'Position', [600, 0, 800, 500]);

figure(2);
clf;
plot(PH);
hold on;
plot(PQ);
title('Power Spectral Densities');
ylabel('Energy (dB)');
xlabel('Frequency Index');
legend({'fh', 'fq'});
set(gcf, 'Position', [0, 0, 600, 400]);