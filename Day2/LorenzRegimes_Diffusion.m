addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');
addpath('../Day1');
rhos = [0.5 350 28];
    
rho = rhos(2);
sigma = 10;
beta = 8/3;

disp('Solving Lorenz system...');
tic;
figure(1);
[t, y] = timeSeries_Lorenz(rho, sigma, beta, 0);
toc;


figure(2);
clf;

disp('Doing Greedy Permutation...');
tic;
[Y, perm, ~] = getGreedyPerm(y, 500);
t2 = t(perm);
toc;

disp('Doing Diffusion Maps...');
KNN = 50; %Number of nearest neighbors
YD = getDiffusionMap(getSSM(Y), KNN);

disp('Computing 1D Persistent Homology...');
tic;
Hs = ripserPC( YD, 41, 1 );
toc;

subplot(231);
plotTimeColors(t, y, 'type', '3DPC');
axis equal;
%plot3(y(:, 1), y(:, 2), y(:, 3));
title('Original Lorenz Solution');
axis equal;

subplot(232);
%plot3(Y(:, 1), Y(:, 2), Y(:, 3), '.');
plotTimeColors(t2, Y, 'type', '3DPC');
axis equal;
title('Greedy Subsampled Lorenz Solution');
axis equal;

subplot(233);
plotTimeColors(t2, YD, 'type', '3DPC');
axis equal;
title('Diffusion Map');

subplot(234);
H0 = Hs{1};
H1 = Hs{2};
H0 = H0(1:end-1, :); %Don't plot essential class
plotDGM(H0);
%plotBarcodes(H0);
axis equal;
title('H0');

subplot(235);
plotDGM(H1);
axis equal;
title('H1');
