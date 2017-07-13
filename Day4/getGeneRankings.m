addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');

load('subsample_GeneData.mat');
X = subsampleGeneData;
N = size(X, 1);
scores = zeros(N, 1);

parfor ii = 1:N
    ii
    scores(ii) = NaivePeriodicityScoring(X(ii, :));
end

save('scores.mat', 'scores');