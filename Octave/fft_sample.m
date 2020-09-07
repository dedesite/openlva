# Sample from https://stackoverflow.com/a/61949815/947242
Fs = 1000;
Ts = 1/Fs;
L = 1500;
t = (0:L-1)*Ts;

S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
X = S + 2*randn(size(t));

figure(1)
plot(1000*t(1:50),X(1:50))
title('Signal Corrupted with Zero-Mean Random Noise')
xlabel('t (milliseconds)')
ylabel('X(t)')

Y = fft(X);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;

figure(2)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

f2 = Fs*(0:(L-1))/L;

figure(3)
plot(f2,P2) 
title('Two-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P2(f)|')