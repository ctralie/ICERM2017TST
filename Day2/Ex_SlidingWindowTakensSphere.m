%An example of Takens' theorem on the sphere, now with a time series
%from a trajectory, using a sliding window to reconstruct
addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

sphere2xyz = @(theta, phi) [cos(theta)*cos(phi), sin(theta)*cos(phi), sin(phi) ];

%% Define dynamical system
%Define observation function as cosine distance to some arbitrary point theta0
theta0 = 0.5;
phi0 = 0.2;
obsfn = @(theta, phi) sum(sphere2xyz(theta0, phi0).*sphere2xyz(theta, phi));

%Fill out a spiral trajectory on the sphere
NTotal = 400;
NPeriods = 20;
phis = linspace(-pi/2, pi/2, NTotal);
thetas = linspace(0, 2*pi*NPeriods, NTotal);

%Apply observation function to trajectory points to get a time series x
x = zeros(NTotal, 1);
X = zeros(NTotal, 3);
for ii = 1:NTotal
    x(ii) = obsfn(thetas(ii), phis(ii));
    X(ii, :) = sphere2xyz(thetas(ii), phis(ii));
end

plot3(X(:, 1), X(:, 2), X(:, 3));


%% Perform Sliding Window Embedding
X = getSlidingWindowNoInterp(x, NTotal/NPeriods);
[~, Y] = pca(X); %Perform PCA on sliding window embedding


%% Compare PH of the original samples to PH of the embedding
DOrig = abs(bsxfun(@minus, thetas(:), thetas(:)')); %All pairs absolute difference
DOrig = min(DOrig, 1 - DOrig); %Enforce circular condition
IsOrig = ripserDM(DOrig, 2, 1);

disp('Doing TDA...');
DX = getSSM(X);
IsSliding = ripserDM(DX, 2, 2);

clf;
subplot(221);
C = plotTimeColors(1:length(x), x, 'type', '2DLine');
title('SSM Original');

subplot(222);
Y = Y(:, 1:3); %Go down to 3D PCA
C = C(1:size(Y, 1), :);
scatter3(Y(:, 1), Y(:, 2), Y(:, 3), 20, C(:, 1:3), 'fill');
title('PCA Phi');

subplot(223);
plotDGM(IsSliding{2});
title('H1');

subplot(224);
plotDGM(IsSliding{3});
title('H2');