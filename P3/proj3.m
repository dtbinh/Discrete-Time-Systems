clc; clear; close all;
%% Audiy Noisy1 with Bandstop

disp('Filtering Noisy 1 using Bandstop Filter of order 12.')
[y1,Fs1] = audioread('noisy1.wav');

% Design the Filter
% All frequency values are normalized to 1.
N      = 12;    % Order
Fpass1 = 0.11;  % First Passband Frequency
Fstop1 = 0.12;  % First Stopband Frequency
Fstop2 = 0.14;  % Second Stopband Frequency
Fpass2 = 0.15;  % Second Passband Frequency
Wpass1 = 1;     % First Passband Weight
Wstop  = 100;     % Stopband Weight
Wpass2 = 1;     % Second Passband Weight
dens   = 20;    % Density Factor

h1  = firpm(N, [0 Fpass1 Fstop1 Fstop2 Fpass2 1], [1 1 0 0 1 1], ...
           [Wpass1 Wstop Wpass2], {dens});
Hd = dfilt.dffir(h1);

% Filter the Signal
y1_filt = conv(y1,h1,'same');

% Save the Filtered Signal
audiowrite('Noisy1_Filtered.wav',y1_filt,Fs1);
% sound(y1_filt, Fs1);

% Extract the Frequency and the impulse response from the filter
[impResp,t] = impz(Hd);
[H,w] = freqz(h1);

% Plot the Responses
figure(1)

subplot(121)
stem(t,impResp)
xlabel('Samples')
ylabel('Amplitude')
grid
title('Noisy 1 Bandstop Filter Impulse Response')
subplot(122)
plot(w/pi,20*log10(abs(H)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Noisy 1 Bandstop Filter Frequency Magnitude Response')

input('Press Any key to go to Noisy2')
%% Audio Noisy 2 with Low Pass Filter
clc; clear; close all;
disp('Filtering Noisy 2 using Gaussian Filter of order 12 and Lowpass filter of order 68.')
disp('Slide the windows to see both figures')
[y2,Fs2] = audioread('noisy2.wav');

% Design the Filter
% All frequency values are normalized to 1.
% Gausian Window Filter
N     = 12;       % Order
Fc    = 0.1;     % Cutoff Frequency
flag  = 'scale';  % Sampling Flag
Alpha = 2.5;      % Window Parameter
win = gausswin(N+1, Alpha);
h2_gauss  = fir1(N, Fc, 'low', win, flag);
Hd2_gauss = dfilt.dffir(h2_gauss);

% Filter the Signal with Gaussian Window
y2_filt = conv(y2,h2_gauss,'same');

% Extract the Frequency and the impulse response from the Gaussian filter
[impResp,t] = impz(Hd2_gauss);
[H,w] = freqz(h2_gauss);

% Plot the Gaussian Filter Responses
figure(2)
subplot(121)
stem(t,impResp)
xlabel('Samples')
ylabel('Amplitude')
grid
title('Noisy 2 Gaussian Filter Impulse Response')
subplot(122)
plot(w/pi,20*log10(abs(H)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Noisy 2 Gaussian Filter Magnitude Response')

% Design another filter - Low Pass Filter
N     = 68;     % Order
Fpass = 0.075;  % Passband Frequency
Fstop = 0.1;   % Stopband Frequency
Wpass = 10;      % Passband Weight
Wstop = 1;      % Stopband Weight
dens  = 20;     % Density Factor
h2_lp  = firpm(N, [0 Fpass Fstop 1], [1 1 0 0], [Wpass Wstop], {dens});
Hd2_lp = dfilt.dffir(h2_lp);

% Filter the Signal further using the LP filter
y2_filt = conv(y2_filt,h2_lp,'same');

% sound(y2_filt,Fs2);

% Save the filtered Signal
audiowrite('Noisy2_Filtered.wav',y2_filt,Fs2);

% Extract the Frequency and the impulse response from the LP filter
[impResp,t] = impz(Hd2_lp);
[H,w] = freqz(h2_lp);

% Plot the Low Pass Filter Responses
figure(3)
subplot(121)
stem(t,impResp)
xlabel('Samples')
ylabel('Amplitude')
grid
title('Noisy 2 Lowpass Filter Impulse Response')

subplot(122)
plot(w/pi,20*log10(abs(H)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Noisy 2 Lowpass Filter Frequency Response')

input('Press Any key to go to Noisy3')
%% Audio Noisy 3 with Low Pass Filter
clc; clear; close all;
disp('Filtering Noisy 2 using Lowpass filter of order 26.')
[y3,Fs3] = audioread('noisy3.wav');

% Design the Filter
% All frequency values are normalized to 1.
% Low Pass Filter
N     = 26;    % Order
Fpass = 0;     % Passband Frequency
Fstop = 0.15;  % Stopband Frequency
Wpass = 1;     % Passband Weight
Wstop = 1;     % Stopband Weight
dens  = 20;    % Density Factor
h3_lp  = firpm(N, [0 Fpass Fstop 1], [1 1 0 0], [Wpass Wstop], {dens});
Hd3_lp = dfilt.dffir(h3_lp);

% Filter the Signal further using the LP filter
y3_filt = conv(y3,h3_lp,'same');
% Amplify the Signal
y3_filt = 2*y3_filt;

% sound(y3_filt,Fs3);
% Save the filtered Signal
audiowrite('Noisy3_Filtered.wav',y3_filt,Fs3);

% Extract the Frequency and the impulse response from the LP filter
[impResp,t] = impz(Hd3_lp);
[H,w] = freqz(h3_lp);

% Plot the Low Pass Filter Responses
figure(4)
subplot(121)
stem(t,impResp)
xlabel('Samples')
ylabel('Amplitude')
grid
title('Noisy 3 Lowpass Filter Impulse Response')
subplot(122)
plot(w/pi,20*log10(abs(H)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Noisy 3 Lowpass Filter Frequency Response')
