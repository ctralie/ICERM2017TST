%Purpose: To show the difference of sliding window embeddings of audio
%novelty functions on music and speech
addpath('../GeometryTools');
addpath('../ripser');
addpath('../TDETools');
addpath('../Audio');

[xspeech, Fs] = audioread('speech.wav');
[xmusic, ~] = audioread('journey.wav');

%Step 1: Get audio novelty functions
winSize = 1024;
hopSize = 256;
xNovSpeech = getAudioNoveltyFn(xspeech, Fs, winSize, hopSize);
xNovSpeech = xNovSpeech(1:1000);
xNovMusic = getAudioNoveltyFn(xmusic, Fs, winSize, hopSize);
xNovMusic = xNovMusic(1:1000);

%Try to get a half of a second window size to match the tempo of Journey
W = round(0.5*(Fs/hopSize)); 
XSpeech = getSlidingWindow(xNovSpeech, W, 1, 2);
XMusic = getSlidingWindow(xNovMusic, W, 1, 2);

%Do normalization to control for amplitude changes
XSpeech = getPCSNorm(XSpeech);
XMusic = getPCSNorm(XMusic);

YSpeech = getPCA(XSpeech);
YMusic = getPCA(XMusic);

disp('Computing persistence diagrams...');
Is = ripserPC(XSpeech, 3, 1);
ISpeech = Is{2};
Is = ripserPC(XMusic, 3, 1);
IMusic = Is{2};

%Times of audio novelty
ts = (1:length(xNovSpeech))*hopSize/Fs;
subplot(231);
plot(ts, xNovMusic);
xlabel('Time (sec)');
ylabel('Audio Novelty');
title('Audio Novelty Music');

subplot(232);
plot3(YMusic(:, 1), YMusic(:, 2), YMusic(:, 3), '.');
title('PCA Sliding Window Music');

subplot(233);
plotDGM(IMusic);
title('Music H1');


subplot(234);
plot(ts, xNovSpeech);
xlabel('Time (sec)');
ylabel('Audio Novelty');
title('Audio Novelty Speech');

subplot(235);
plot3(YSpeech(:, 1), YSpeech(:, 2), YSpeech(:, 3), '.');
title('PCA Sliding Window Speech');

subplot(236);
plotDGM(ISpeech);
title('Speech H1');

