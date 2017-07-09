addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');
%rhos = [0.5 28 99.65];
    
rho = 28;
sigma = 10;
beta = 8/3;

[t, y] = timeSeries_Lorenz(rho, sigma, beta);

disp('Doing Greedy Permutation...');
tic;
Y = getGreedyPerm(y, 1000);
toc;

disp('Computing 1D Persistent Homology...');
Is = ripserPC( Y, 3, 1 );
I1 = Is{2};

subplot(131);
plotTimeColors(1:size(y, 1), y, '3DLine');
plot3(y(:, 1), y(:, 2), y(:, 3));
plot3(Y(:, 1), Y(:, 2), Y(:, 3), '.')