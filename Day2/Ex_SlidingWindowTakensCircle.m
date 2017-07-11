%An example of Takens' theorem on the circle, now with a time series
%from a trajectory, using a sliding window to reconstruct
addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

%% Define dynamical system
%Define observation function as distance to some arbitrary point theta0
theta0 = 0.1;
obsfn = @(theta) min(abs(theta - theta0), 1 - abs(theta - theta0));

%Fill out a trajectory on the circle
NTotal = 600;
dTheta = sqrt(5)/200; %Play with this
thetas = zeros(NTotal, 1);
for ii = 2:NTotal
    thetas(ii) = mod(thetas(ii-1) + dTheta, 1);
end

%Apply observation function to trajectory points to get a time series x
x = obsfn(thetas);


%% Perform Sliding Window Embedding
%Play with these parameters
dim = 30;
Tau = 0.5;
dT = 1;
X = getSlidingWindow(x, dim, Tau, dT);
[~, Y] = pca(X); %Perform PCA on sliding window embedding


%% Compare PH of the original samples to PH of the embedding
DOrig = abs(bsxfun(@minus, thetas(:), thetas(:)')); %All pairs absolute difference
DOrig = min(DOrig, 1 - DOrig); %Enforce circular condition
IsOrig = ripserDM(DOrig, 2, 1);

disp('Doing TDA...');
DX = getSSM(X);
IsSliding = ripserDM(DX, 2, 1);

subplot(221);
C = plotTimeColors(1:length(x), x, 'type', '2DLine');
title('SSM Original');

subplot(222);
Y = Y(:, 1:3); %Go down to 3D PCA
C = C(1:size(Y, 1), :);
scatter3(Y(:, 1), Y(:, 2), Y(:, 3), 20, C(:, 1:3), 'fill');
title('SSM Phi');

subplot(223);
plotDGM(IsOrig{2});
title('H1 Original');

subplot(224);
plotDGM(IsSliding{2});
title('H1 Sliding Window');