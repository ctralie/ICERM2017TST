function [ score, X ] = NaivePeriodicityScoring( x )
    addpath('../TDETools');
    addpath('../ripser');
    addpath('../GeometryTools');
    N = length(x);
    W = N/2; %We know each signal goes through two periods
    dim = 20; %Play around with this
    Tau = W/dim; %Regardless, choose a Tau so the window length is W
    X = getSlidingWindow(x, dim, Tau, 1);
    X = getPCSNorm(X);
    Is = ripserPC(X, 41, 1);
    H1 = Is{2};
    mp = max(H1(:, 2) - H1(:, 1)); %Maximum persistence
    score = mp/sqrt(3); %Normalize score to the range [0, 1]
    
    clf;
    subplot(231);
    plot(x);
    title('Signal');
    subplot(232);
    plotDGM(H1);
    title(sprintf('mp = %g', score));
    subplot(233);
    imagesc(getSSM(X));
    title('SSM');
    Y = getPCA(X);
    subplot(2, 3, 4:6);
    plot3(Y(:, 1), Y(:, 2), Y(:, 3), '.');
    title('PCA');
    axis equal;
end

