addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

[Periodics, NonPeriodics] = makePeriodicDataset(1, 0.5, 200);
PScores = zeros(size(Periodics, 1), 1);
NPScores = zeros(size(NonPeriodics, 1), 1);

parfor ii = 1:length(PScores)
    ii
    score = NaivePeriodicityScoring(Periodics(ii, :));
    PScores(ii) = score;
    score = NaivePeriodicityScoring(NonPeriodics(ii, :));
    NPScores(ii) = score;
end

[FP, TP] = getROC(PScores, NPScores);
getAUROC(FP, TP)