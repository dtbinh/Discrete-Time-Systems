% Mohak Kant - R11481106
clc; clear; close all;

%Read Original Signal
[x, fs] = audioread('noisy_chirp.wav');
ts = 1/fs;
l = length(x);
nts = linspace(0,ts*l,l);
% plot(nts,x);
% xlabel('Time in s');
% ylabel('Amplitude');

%% Part 1 - Plot the FFT of the signal

% Relationship Between k and O => O = 2*pi*k/N, where N is the number of
% points used in FFT calculation.

N = length(x);
xdft = fft(x);
xdft = xdft(1:N/2+1);
psdx = (1/(2*pi*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:(2*pi)/N:pi;

plot(freq/pi,10*log10(psdx))
grid on
title('Power Spectral Density')
xlabel('Normalized Frequency (\times\pi rad/sample)') 
ylabel('Power (dB/rad/sample)')

disp('Part 1')
disp('Relationship Between k and Omega => Omega = 2*pi*k/N, where N is the number of points used in FFT calculation.')
input('Press Any Key to continue to Part - 2')

% Resources: https://www.mathworks.com/help/signal/ug/power-spectral-density-estimates-using-fft.html
% Studied about chirp Signal from: https://www.gaussianwaves.com/2014/07/chirp-signal-frequency-sweeping-fft-and-power-spectral-density/
%% Part 2 - 
disp('Part 2')
disp('The Noise is present in the range 800Hz-1.4kHz. It was identified from the PSD')
disp('The Chirp Signal is present in the range 320Hz-6kHz. It was identified from the PSD')

disp('How I Proceeded? -  I identified the normailzed frequency for the signal and the noised from the power spectral density plot. For the Noise it was approximately 0.1 to 0.18 and for the signal it was approximately 0.04 to 0.75. Then I converted normalized frequency to Hertz using  f = Omega*fs/(2*pi) ')
input('Press Any Key to continue to Part - 3')
% The Noise is present in the range 800Hz-1.4kHz. It was identified from the PSD
% The Chirp Signal is present in the range 320Hz-6kHz. It was identified from the PSD
% How I Proceeded? -  I identified the normailzed frequency for the signal
% and the noised from the power spectral density plot. For the Noise it was
% approximately 0.1 to 0.18 and for the signal it was approximately 0.04
% to 0.75. Then I converted normalized frequency to Hertz using 
% f = Omega*fs/(2*pi)
% 

%% Part 3 - IIR Filter of order 10
clc; close all;
N   = 10;   % Order
Fc1 = 0.1;  % First Cutoff Frequency
Fc2 = 0.2;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandstop('N,F3dB1,F3dB2', N, Fc1, Fc2);
Hd_iir = design(h, 'butter');
[HIiir, w] = freqz(Hd_iir);

figure
subplot(121)
plot(w/pi,20*log10(abs(HIiir)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Frequency Magnitude Response')

subplot(122)
plot(w/pi,(angle(HIiir)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Phase Frequency freqzResponse')
title('Phase Frequency Response')

zplane(Hd_iir)

x_filtered_iir = filter(Hd_iir, x);

% The Filter is stable as all the poles lie inside the Z-plane Unit Circle

disp('Part 3')
disp('The Filter is stable as all the poles lie inside the Z-plane Unit Circle')
input('Press Any Key to continue to Part - 4')

% Studied IIR Filter from: https://www.youtube.com/channel/UCfFq8r---cp2IBwoGcWWsvw

%% Part 4 - FIR Equivalent Filter
clc; close all;
% Filter Order has to be atleast 100.

N      = 100;   % Order
Fpass1 = 0.05;  % First Passband Frequency
Fstop1 = 0.1;   % First Stopband Frequency
Fstop2 = 0.2;   % Second Stopband Frequency
Fpass2 = 0.25;  % Second Passband Frequency
Wpass1 = 1;     % First Passband Weight
Wstop  = 1;     % Stopband Weight
Wpass2 = 1;     % Second Passband Weight
dens   = 20;    % Density Factor

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, [0 Fpass1 Fstop1 Fstop2 Fpass2 1], [1 1 0 0 1 1], ...
           [Wpass1 Wstop Wpass2], {dens});
Hd = dfilt.dffir(b);

[HFir, w] = freqz(Hd);
[hFir, tFir] = impz(Hd);

figure
subplot(121)
plot(w/pi,20*log10(abs(HFir)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Frequency Magnitude Response')

subplot(122)
plot(w/pi,(angle(HFir)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Phase Frequency freqzResponse')
title('Phase Frequency Response')

zplane(Hd)

x_filtered_fir = filter(hFir, 1, x);

% I Prefer, the IIR Filter.
disp('Part 4')
disp('Filter Order of 100 used')
disp('I prefer the IIR Filter')
input('Press Any Key to continue to Part - 5')

% Resources for FIR filter Design Order: https://dsp.stackexchange.com/questions/31066/how-many-taps-does-an-fir-filter-need

%% Part 5 
clc; close all;
[b,a] = sos2tf(Hd_iir.sosMatrix);
x_filtered_iir_2 = filter(b,a,x);

freqz(b,a)
figure
zplane(b,a)

disp('Part 5')
disp('There is a phase difference but here both are stable.')
disp('SOS cascaded filters are generally less prone to instability and coefficient quantization errors. So, I prefer those but in this case both are stable.')
input('Press Any Key to continue to Part - 6')

% Resources: Dr Tanja Karp, IIR Filter Design Slides

%% Part 6
clc; close all;
audiowrite('noisy_chirp_filtered.wav', x_filtered_iir, fs);

% The Audio signal is unrecoverable for the duration from approximately 0.5s 
% to approximately 1sec. The chirp signal here is unrecoverable as the
% chirp signal and noise are present in the same frewuency range and
% overlap (0.1 - 0.18 Normalized Frequency). Thus, the bandstop  filter
% created attenuates even the signal present.

% Yes, I was able to remove the noise from the signal for the remaining
% time

disp('Part 6')
disp('The Audio signal is unrecoverable for the duration from approximately 0.5s to approximately 1sec. The chirp signal here is unrecoverable as the chirp signal and noise are present in the same frewuency range and overlap (0.1 - 0.18 Normalized Frequency). Thus, the bandstop  filter created attenuates even the signal present.')
disp('Yes, I was able to remove the noise from the signal for the remaining time')
input('Press Any Key to continue to Part - 7')
%% Part 7
% Filtered for between time period of 2-3 Seconds

% Yes, the filter is stable, as all the poles lie inside the unit circle

% To Design the filter, I looked at the spectogram of the signal using 
% signalAnalyzer and converted the sample number to time using fs. 
% For eg: Sample 32000 corresponds to the time index of 2sec if the 
% sampling frequency is 16000Hz. I noted the frequency of the 
% signal present at the sample 32000 and then correspondly noted 
% the frequency of the signal at sample 48000 corresponding to time 
% index of 3sec. Then I created a passband filter with these low and 
% high cutoff frequencies using filterDesigner.

disp('Filtered for between time period of 2-3 Seconds');
disp('Yes, the filter is stable, as all the poles lie inside the unit circle');
disp('To Design the filter, I looked at the spectogram of the signal using signalAnalyzer and converted the sample number to time using fs. For eg: Sample 32000 corresponds to the time index of 2s if the sampling frequency is 16000Hz. I noted the frequency of the signal present at the sample 32000 and then correspondly noted the frequency of the signal at sample 48000 corresponding to time index of 3sec. Then I created a passband filter with these low and high cutoff frequencies using filterDesigner. '); 
close all;

N   = 10;     % Order
Fc1 = 0.495;  % First Cutoff Frequency
Fc2 = 0.62;   % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2);
Hd_1_sec = design(h, 'butter');

x_filtered_1_sec = filter(Hd_1_sec,x);
% audiowrite('noisy_chirp_filtered2.wav', x_filtered_1_sec, fs);

[H_1_sec, w] = freqz(Hd_1_sec);

figure
subplot(121)
plot(w/pi,20*log10(abs(H_1_sec)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Frequency Magnitude Response')

subplot(122)
plot(w/pi,(angle(H_1_sec)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Phase Frequency freqzResponse')
title('Phase Frequency Response')


zplane(Hd_1_sec)
