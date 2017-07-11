%An example of Takens' theorem on the cylinder
addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

%% Define dynamical system
%Define dynamics
dTheta = 0.1;
phi = @(theta, y) [mod(theta + dTheta, 1), y]; %Move around circles on cylinder

%Define observation function as distance to some arbitrary point (theta0, y0)
theta0 = 0.2;
y0 = 0.5;
obsfn = @(theta, y) abs(y - y0) + min(abs(theta - theta0), 1 - abs(theta - theta0));

%% Run dynamics from a bunch of seed points
d = 10; %Number of iterations of dynamics
NCircle = 20; %Number of points around each circle
xcircle = linspace(0, 1, NCircle);
NHeight = 20; %Number of points up the height
xheight = linspace(0, 1, NHeight);
%Make a grid of points on the cylinder
[thetas, ys] = meshgrid(xcircle, xheight);
%Flatten grid to 1D arrays for convenience
thetas = thetas(:);
ys = ys(:);

N = length(ys); %Total number of points in grid
Phi = zeros(N, d+1);
for ii = 1:N
    thetacurr = thetas(ii);
    ycurr = ys(ii);
    for jj = 1:d+1
        Phi(ii, jj) = obsfn(thetacurr, ycurr);
        res = phi(thetacurr, ycurr); %Iterate
        thetacurr = res(1);
        ycurr = res(2);
    end
end

%% Compare PH of the original samples to PH of the embedding
Y = getPCA(Phi);
DPhi = getSSM(Phi);
IsPhi = ripserDM(DPhi, 2, 1);

subplot(121);
plotDGM(IsPhi{2});
title('H1 Phi');

subplot(122);
%plot3(Y(:, 1), Y(:, 2), Y(:, 3), '.');
plotTimeColors(1:size(Y, 1), Y, 'type', '3DPC');
axis equal;
title('PCA Phi');