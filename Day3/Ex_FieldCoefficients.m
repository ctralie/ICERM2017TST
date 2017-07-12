%Purpose: To show the effect of changing the field of coefficients
addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

T = 40;
NPeriods = 4;
N = T*NPeriods;
t = linspace(0, 2*pi*NPeriods, N);

y1 = 0.8*cos(t) + 0.6*cos(2*t);
y2 = 0.6*cos(t) + 0.8*cos(2*t);

%Implicitly set Tau = 1, dT = 1
Y1 = getSlidingWindowNoInterp(y1, T);
Y2 = getSlidingWindowNoInterp(y2, T);
Z1 = getPCA(Y1);
Z2 = getPCA(Y2);
H11_2 = ripserPC(Y1, 2, 1); H11_2 = H11_2{2};
H11_3 = ripserPC(Y1, 3, 1); H11_3 = H11_3{2};
H12_2 = ripserPC(Y2, 2, 1); H12_2 = H12_2{2};
H12_3 = ripserPC(Y2, 3, 1); H12_3 = H12_3{2};

subplot(241);
C = plotTimeColors(1:N, y1, 'type', '2DLine');
title('0.8cos(t) + 0.6cos(2t)');
subplot(242);
scatter3(Z1(:, 1), Z1(:, 2), Z1(:, 3), 20, C(1:size(Z1, 1), 1:3), 'fill');
title('Sliding Window PCA');
subplot(243);
plotDGM(H11_2);
title('Z2 Coefficients');
subplot(244);
plotDGM(H11_3);
title('Z3 Coefficients');

subplot(245);
C = plotTimeColors(1:N, y2, 'type', '2DLine');
title('0.6cos(t) + 0.8cos(2t)');
subplot(246);
scatter3(Z2(:, 1), Z2(:, 2), Z2(:, 3), 20, C(1:size(Z1, 1), 1:3), 'fill');
title('Sliding Window PCA');
subplot(247);
plotDGM(H12_2);
title('Z2 Coefficients');
subplot(248);
plotDGM(H12_3);
title('Z3 Coefficients');