%Generate all types of signals
function [Periodics, NonPeriodics] = makePeriodicDataset(seed, level, NSignals)
    addpath('NoiseTypes');
    rng(seed);
    %Make all signals period length 100 with 2 periods
    T = 100;
    NPeriods = 2;
    N = T*NPeriods;
    
    %% Step 1: Make all periodic signals
    xTriangle = zeros(N, 1);
    xSquare = zeros(N, 1);
    for ii = 1:NPeriods
        idx = 1 + (ii-1)*T;
        xSquare(idx:idx+T/2) = 1;
        xTriangle(idx:idx+T-1) = 0:T-1;
    end
    xTriangle = xTriangle/max(xTriangle);
    xCosine = cos(2*pi*(1:N)/T) + 0.5*cos(2*pi*(1:N)/(0.5*T));
    
    Periodics = zeros(NSignals, N);
    for ii = 1:NSignals
        facs = randn(1, 3);
        facs = facs/sqrt(sum(facs.^2));
        x = facs(1)*getRandomPhaseShift(xCosine) + ... 
            facs(2)*getRandomPhaseShift(xSquare) + ...
            facs(3)*getRandomPhaseShift(xTriangle);
        x = getRandomReparam(x, 1);
        x = getSpikeNoise(x, level);
        x = getAWGN(x, level);
        Periodics(ii, :) = x;
    end
    
    
    %% Step 2: Make all nonperiodic signals
    ramp = (1:N)/N;
    parab = (1:N).^2/(N*N);
    circ = sqrt(1-linspace(0, 1, N).^2);
    ran = randn(1, N);
    NonPeriodics = zeros(NSignals, N);
    for ii = 1:NSignals
        facs = randn(1, 4);
        facs = facs/sqrt(sum(facs.^2));
        x = facs(1)*ramp + facs(2)*parab + facs(3)*circ + facs(4)*ran;
        x = getRandomReparam(x, 1);
        x = getSpikeNoise(x, level);
        x = getAWGN(x, level);
        NonPeriodics(ii, :) = x;
    end
end