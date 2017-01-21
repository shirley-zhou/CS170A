function plot_spectrum( wav_file )
[audio_sequence, sampling_freq] = wavrad( wav_file );  %  audioread( audio_file );
n = size(audio_sequence,1);

frequencies = linspace(0,sampling_freq, n);
first_half = 2:(n/2+1);
figure
if size(audio_sequence,2) == 2
    spectrum1 = abs(fft(audio_sequence(:,1)));
    spectrum2 = abs(fft(audio_sequence(:,2)));
    plot(frequencies(first_half),  spectrum1(first_half), 'b', ...
         frequencies(first_half), -spectrum2(first_half), 'g')
else
    spectrum1 = abs(fft(audio_sequence(:,1)));
    plot(frequencies(first_half), spectrum1(first_half), 'b')
end
