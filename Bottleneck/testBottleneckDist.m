addpath('../ripser');
rng(30);

t = linspace(0, 2*pi, 200);
X = zeros(length(t)*2, 2);
X(1:length(t), 1) = cos(t);
X(1:length(t), 2) = sin(t);
X(length(t)+1:end, 1) = 2*cos(t) + 5;
X(length(t)+1:end, 2) = 2*sin(2*t) + 5;

Is = ripserPC(X, 2, 1);
S = Is{2};

Y = X + 0.5*randn(size(X, 1), 2);
Is = ripserPC(Y, 2, 1);
T = Is{2};

bdist = getBottleneckDist(S, T)

dlmwrite('PD1.txt', S, ' ');
dlmwrite('PD2.txt', T, ' ');

%Test against Dionysus
system('./bottleneck PD1.txt PD2.txt');
