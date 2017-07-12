N = 127; %Number of points (make sure it's odd)

%Define a discrete function (feel free to play with this)
%This example uses a two Gaussian bump function
sigma = 5;
idx = 1:N; idx = idx(:);
x = exp(-(idx-20).^2/(2*sigma.^2));
x = x + exp(-(idx-80).^2/(2*sigma.^2));
sigma = 1;
x = x + exp(-(idx-50).^2/(2*sigma.^2));

%Initialize Fourier Basis
H = FourierMatrix(N);

AnimationSpeed = 2; %Number of frames per second
y = zeros(N, 1);
for k = 1:N
    projFac = H(k, :)*x;
    proj = projFac*H(k, :)';
    y = y + proj;
    
    dist = sqrt(sum((y-x).^2));
    
    clf;
    plot(y, 'k');
    hold on;
    plot(proj, 'r');
    plot(x, 'b--', 'LineWidth', 2);
    ylim([-max(x(:))/3, max(x(:))*1.2]);
    xlim([0, N]);
    title(sprintf('%i Fourier Modes, L2 Dist = %.3g', k, dist));
    pause(1/AnimationSpeed);
end