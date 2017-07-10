addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');
rhos = [0.5 350 28];
    
rho = rhos(2);
sigma = 10;
beta = 8/3;

disp('Solving Lorenz system...');
tic;
figure(1);
[t, y] = timeSeries_Lorenz(rho, sigma, beta);
toc;


figure(2);
clf;

disp('Doing Greedy Permutation...');
tic;
[Y, perm, ~] = getGreedyPerm(y, 500);
t2 = t(perm);
toc;

disp('Computing 1D Persistent Homology...');
tic;
Is = ripserPC( Y, 41, 1 );
toc;

subplot(221);
plotTimeColors(t, y, 'type', '3DPC');
%plot3(y(:, 1), y(:, 2), y(:, 3));
title('Original Lorenz Solution');
axis equal;

subplot(222);
%plot3(Y(:, 1), Y(:, 2), Y(:, 3), '.');
plotTimeColors(t2, Y, 'type', '3DPC');
title('Greedy Subsampled Lorenz Solution');
axis equal;

subplot(223);
plotDGM(Is{1});
axis equal;
title('H0');

subplot(224);
plotDGM(Is{2});
axis equal;
title('H1');