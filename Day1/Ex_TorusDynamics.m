addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

N = 400;
dTheta = 0.5;
dPhi = dTheta*pi/3;

thetas = zeros(N, 1);
phis = zeros(N, 1);

for ii = 2:N
    thetas(ii) = mod(thetas(ii-1) + dTheta, 2*pi);
    phis(ii) = mod(phis(ii-1) + dPhi, 2*pi);
end

%Compute the L1 distance ("Manhattan distance") on the flat torus
DTheta = abs(bsxfun(@minus, thetas(:), thetas(:)'));
DTheta(DTheta > pi) = 2*pi - DTheta(DTheta > pi);
DPhi = abs(bsxfun(@minus, phis(:), phis(:)'));
DPhi(DPhi > pi) = 2*pi - DPhi(DPhi > pi);
D = DTheta + DPhi;

disp('Computing persistent homology...');
Is = ripserDM(D, 2, 2);
disp('Finished computing persistent homology');
subplot(221);
scatter(thetas, phis, 20, 'fill');
xlabel('theta');
ylabel('phi');
xlim([0, 2*pi]);
ylim([0, 2*pi]);

subplot(222);
plotDGM(Is{1}(1:end-1, :));
title('H0');

subplot(223);
plotDGM(Is{2});
title('H1');

subplot(224);
plotDGM(Is{3});
title('H2');