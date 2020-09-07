# Inspiré de 
# https://www.mathworks.com/matlabcentral/answers/22112-how-to-plot-wav-file
# Et de
# https://stackoverflow.com/questions/25797670/plotting-fft-on-octave


#
# Affichage du contenu du wav
#
[audiodata, fs] = wavread("andreas.wav");
# On ne prend que le channel 1, le 2 ne semble pas utilisé
audiodata_one = audiodata(:,1);

# 20s à 96000Hz
step = 1/fs;
sample_length = length(audiodata_one)*step;
t = 0:step:sample_length-step;

subplot(4,1,1)
plot(t, audiodata_one);
xlabel('Seconds'); ylabel('Amplitude');

#
# Affichage des composantes spectrales du wav
#
spectr = fft(audiodata_one)

fs/length(spectr)

subplot(4,1,2)
plot(t,abs(spectr))
xlabel("Frequency")
ylabel("Signal amplitude")


P2 = abs(spectr/sample_length);
P1 = P2(1:sample_length/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fs*(0:(sample_length/2))/sample_length;

subplot(4,1,3)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of wavfile(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
%{
f2 = fs*(0:(sample_length-1))/sample_length;

subplot(4,1,4)
plot(f2,P2)
title('Two-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P2(f)|')
%}