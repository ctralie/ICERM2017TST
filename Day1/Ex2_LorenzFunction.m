addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

rhos = [0.5 350 28];
    
rho = rhos(2);
sigma = 10;
beta = 8/3;

[t, y] = timeSeries_Lorenz(rho, sigma, beta);

x = g(y); %Apply the function

%Get a sliding window with 3 samples
dim = 3;
Tau = 10;
dT = 1;
disp('Getting sliding window embedding...');
Y = getSlidingWindowInteger(x, dim, Tau, dT);

%Do persistent homology on original and sliding window result 
%after a greedy permutation
[yg, ~, ~] = getGreedyPerm(y, 500);
disp('Running persistent homology on original solution...');
Is1 = ripserPC(yg, 3, 1);
[Yg, ~, ~] = getGreedyPerm(Y, 500);
disp('Running persistent homology on sliding window embedding...');
Is2 = ripserPC(Yg, 3, 1);

%Plot original time series, sliding window with 3 samples
subplot(321);
plot3(y(:, 1), y(:, 2), y(:, 3));
title('Original Lorenz Solution');
subplot(323);
plotDGM(Is1{1}(1:end-1, :));
title('H0 for Original Lorenz');
subplot(325);
plotDGM(Is1{2});
title('H1 for Original Lorenz');

subplot(322);
plot3(Y(:, 1), Y(:, 2), Y(:, 3));
title('Dimension 3 Sliding Window Embedding');
subplot(324);
plotDGM(Is2{1}(1:end-1, :));
title('H0 for Sliding Window Embedding');
subplot(326)
plotDGM(Is2{2});
title('H1 for Sliding Window Embedding');
