audiofile = 'untune.wav';
[untune, Fs] = audioread(audiofile);
y = untune(:,1); % first track of the stereo clip

n = size(y, 1)

power = abs(fft(y));
freqspectrum = linspace(1, Fs, n);
plot(freqspectrum, power);

n = floor(n/2);
power = power(1:n);
halfspectrum = linspace(1, Fs/2, n);
plot(halfspectrum, power);
axis([100 600 0 inf]);
