# Taken from
# https://www.gaussianwaves.com/2014/07/how-to-plot-fft-using-matlab-fft-of-basic-signals-sine-and-cosine-waves/

f=10; %frequency of sine wave
overSampRate=30; %oversampling rate
fs=overSampRate*f; %sampling frequency
phase = 1/3*pi; %desired phase shift in radians
nCyl = 5; %to generate five cycles of sine wave

t=0:1/fs:nCyl*1/f; %time base

x=sin(2*pi*f*t+phase); %replace with cos if a cosine wave is desired
subplot(4,2,1);
plot(t,x);
title(['Sine Wave f=', num2str(f), 'Hz']);
xlabel('Time(s)');
ylabel('Amplitude');
#
# Plotting raw values of DFT
#

%{
The x-axis runs from 0 to N-1 – representing N sample values.
Since the DFT values are complex, the magnitude of the DFT abs(X) is plotted on the y-axis.
From this plot we cannot identify the frequency of the sinusoid that was generated.
see: https://www.gaussianwaves.com/2015/11/interpreting-fft-results-complex-dft-frequency-bins-and-fftshift/
%}
NFFT=1024; %NFFT-point DFT      
X=fft(x,NFFT); %compute DFT using FFT        
nVals=0:NFFT-1; %DFT Sample points       
subplot(4,2,2);
plot(nVals,abs(X));      
title('Double Sided FFT - without FFTShift');        
xlabel('Sample points (N-point DFT)')        
ylabel('DFT Values');

#
# FFT plot – plotting raw values against Normalized Frequency axis
#

%{
In the next version of plot, the frequency axis (x-axis) is normalized to unity.
Just divide the sample index on the x-axis by the length N of the FFT.
This normalizes the x-axis with respect to the sampling rate f_s.
Still, we cannot figure out the frequency of the sinusoid from the plot.
%}
NFFT=1024; %NFFT-point DFT      
X=fft(x,NFFT); %compute DFT using FFT        
nVals=(0:NFFT-1)/NFFT; %Normalized DFT Sample points
subplot(4,2,3);
plot(nVals,abs(X));      
title('Double Sided FFT - without FFTShift');        
xlabel('Normalized Frequency')       
ylabel('DFT Values');

#
# FFT plot – plotting raw values against normalized frequency
# (positive & negative frequencies)
#

%{
As you know, in the frequency domain, the values take up both positive and negative frequency axis.
In order to plot the DFT values on a frequency axis with both positive and negative values,
the DFT value at sample index 0 has to be centered at the middle of the array.
This is done by using FFTshift function in Matlab. 
The x-axis runs from -0.5 to 0.5 where the end points are
the normalized ‘folding frequencies’ with respect to the sampling rate f_s.
%}

NFFT=1024; %NFFT-point DFT      
X=fftshift(fft(x,NFFT)); %compute DFT using FFT      
fVals=(-NFFT/2:NFFT/2-1)/NFFT; %DFT Sample points    
subplot(4,2,4);
plot(fVals,abs(X));      
title('Double Sided FFT - with FFTShift');       
xlabel('Normalized Frequency');    
ylabel('DFT Values');

#
# FFT plot – Absolute frequency on the x-axis Vs Magnitude on Y-axis
#

%{
Here, the normalized frequency axis is just multiplied by the sampling rate.
From the plot below we can ascertain that the absolute value of FFT peaks at 10Hz and -10Hz.
Thus the frequency of the generated sinusoid is 10 Hz.
The small side-lobes next to the peak values at 10Hz and -10Hz are due to spectral leakage.
see https://www.gaussianwaves.com/2011/01/fft-and-spectral-leakage-2/
%}
NFFT=1024;      
X=fftshift(fft(x,NFFT));
fVals=fs*(-NFFT/2:NFFT/2-1)/NFFT;
subplot(4,2,5);  
plot(fVals,abs(X),'b');
title('Double Sided FFT - with FFTShift');
xlabel('Frequency (Hz)');
ylabel('|DFT Values|');

#
# Power Spectrum – Absolute frequency on the x-axis Vs Power on Y-axis:
#

%{
The following is the most important representation of FFT.
It plots the power of each frequency component on the y-axis and the frequency on the x-axis.
The power can be plotted in linear scale or in log scale.
The power of each frequency component is calculated as
P_x(f)=X(f)X^{*}(f)
Where X(f) is the frequency domain representation of the signal x(t).
In Matlab, the power has to be calculated with proper scaling terms
(since the length of the signal and transform length of FFT may differ from case to case).
%}

NFFT=1024;
L=length(x);         
X=fftshift(fft(x,NFFT));         
Px=X.*conj(X)/(NFFT*L); %Power of each freq components       
fVals=fs*(-NFFT/2:NFFT/2-1)/NFFT;
subplot(4,2,6);  
# Absolute version
plot(fVals,Px,'b');
title('Power Spectral Density');         
xlabel('Frequency (Hz)')         
ylabel('Power');

NFFT=1024;
L=length(x);         
X=fftshift(fft(x,NFFT));         
Px=X.*conj(X)/(NFFT*L); %Power of each freq components       
fVals=fs*(-NFFT/2:NFFT/2-1)/NFFT;
subplot(4,2,7);  
# Log version
plot(fVals,10*log10(Px),'b');
title('Power Spectral Density (log scale)');         
xlabel('Frequency (Hz)')         
ylabel('Power');

#
# Power Spectrum – One-Sided frequencies
#

%{
In this type of plot, the negative frequency part of x-axis is omitted.
Only the FFT values corresponding to 0 to N/2 sample points of N-point DFT are plotted.
Correspondingly, the normalized frequency axis runs between 0 to 0.5.
The absolute frequency (x-axis) runs from 0 to f_s/2.
%}

L=length(x);        
NFFT=1024;       
X=fft(x,NFFT);       
Px=X.*conj(X)/(NFFT*L); %Power of each freq components       
fVals=fs*(0:NFFT/2-1)/NFFT;  
subplot(4,2,8);     
# plot(fVals,Px(1:NFFT/2),'b','LineSmoothing','on','LineWidth',1);
plot(fVals,Px(1:NFFT/2),'b');
title('One Sided Power Spectral Density');       
xlabel('Frequency (Hz)')         
ylabel('PSD');
