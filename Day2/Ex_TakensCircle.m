%An example of Takens' theorem on the circle
%Students TODO: Play around with dynamics (anonymous function phi)
%the observation function (obsfn), and the number of iterations of the 
%dynamical system (d)
addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

%% Define dynamical system
%Define dynamics
dTheta = 0.1;
phi = @(theta) mod(theta + dTheta, 1);

%Define observation function as distance to some arbitrary point theta0
theta0 = 0.1;
obsfn = @(theta) min(abs(theta - theta0), 1 - abs(theta - theta0));

%% Run dynamics from a bunch of seed points
d = 10; %Number of iterations of dynamics
N = 200; %Number of points
thetas = linspace(0, 1, N);
Phi = zeros(N, d+1);
for ii = 1:N
    xcurr = thetas(ii);
    for jj = 1:d+1
        Phi(ii, jj) = obsfn(xcurr);
        xcurr = phi(xcurr); %Iterate
    end
end

%% Compare PH of the original samples to PH of the embedding
DOrig = abs(bsxfun(@minus, thetas(:), thetas(:)')); %All pairs absolute difference
DOrig = min(DOrig, 1 - DOrig); %Enforce circular condition
IsOrig = ripserDM(DOrig, 2, 1);

DPhi = getSSM(Phi);
IsPhi = ripserDM(DPhi, 2, 1);

subplot(221);
imagesc(DOrig);
title('SSM Original');

subplot(223);
plotDGM(IsOrig{2});
title('H1 Original');

subplot(222);
imagesc(DPhi);
title('SSM Phi');

subplot(224);
plotDGM(IsPhi{2});
title('H1 Phi');