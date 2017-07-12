%Purpose: Make a square length with different period lengths, and 
%record the maximum 1D persistence for different window lengths, keeping
%the embedding dimension fixed
%Student TODO: Play with period length and signal type (square wave,
%triangle wave, cosine)
addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

T = 40; %Period Length
d = 10; %Choose a sufficient embedding dimension in advance
NPeriods = 4; %Only a few periods are needed to show the effect

%Make the triangle wave, square wave, and ordinary cosine with the specified period
N = T*NPeriods;
xTriangle = zeros(N, 1);
xSquare = zeros(N, 1);
for ii = 1:NPeriods
    idx = 1 + (ii-1)*T;
    xSquare(idx:idx+T/2) = 1;
    xTriangle(idx:idx+T-1) = 0:T-1;
end
xCosine = cos(2*pi*(1:N)/T);


%Chose the cosine signal (change this)
x = xCosine;


%Run persistent homology with different window lengths, keeping dimension
%fixed
Wins = 2:T*2;
maxps = zeros(length(Wins), 1);
for ii = 1:length(maxps)
    fprintf(1, '.');
    Tau = Wins(ii)/d;
    X = getSlidingWindow(x, d, Tau, 1);
    Is = ripserPC(X, 2, 1);
    H1 = Is{2};
    if numel(H1) > 0
        maxps(ii) = max(H1(:, 2) - H1(:, 1));
    end
end
fprintf(1, '\n\n');

clf;
subplot(121);
plot(x, 'k');
subplot(122);
plot(Wins, maxps);
xlabel('Window Size');
ylabel('Maximum Persistence');