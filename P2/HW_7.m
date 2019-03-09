% Discrete Time Signals, Homework 7: FIR
% Mohak Kant
% Answers included in comments of this matlab file. Please Press enter
% after each part is executed to move to the next part. Current executing
% part is displayed in the console

clc; clear; close all;

%% Part 1: Create Impulse Response and plot it
N = 10;
omega_c = pi/8;
n = 0:N;
h_n = (omega_c/pi)*sinc(omega_c*(n-N/2)/pi);
subplot(121)
stem(n,h_n);
title('Impluse Response in Time domain')

input('Part 1, press enter to continue')

%% Part 2 and 3: Impulse Response in Freq Domain
omega = linspace(-pi,pi,1000);
H = freqz(h_n,1,omega);
magnitudeFreqResH = abs(H);
subplot(122)
plot(omega,magnitudeFreqResH); 
title('Impluse Response in Frequency domain')
input('Part 2 and 3, press enter to continue')
% 3: This Clearly shows that the frequency response has even
   % symmetry
                
%% Part 4
% 4: The filter given is a lowpass filter. Omega_c = pi/10 = approx +/- 0.311

%% Part 5: Cosine in Passband
fs = 1000;
t = linspace(0,1,fs);
omega_in_bandpass = pi/10;
cos_X = cos(40*pi*t);
figure
% subplot(121)
% plot(t,cos_X);
% title('x[n] Cosine with frequency in BandPass')
y_n = conv(cos_X,h_n,'same');
% subplot(122)
plot(t,y_n);
title('y[n] Cosine in bandpass Filtered')
input('Part 5, press enter to continue')
% Frequency Domain Analysis: As the frequency of cosine is in the bandpass
% region of the Frequency Magnitude Response Filter, the cosine wave is
% left without any change.

%% Part 6: Cosine in Stopband
t = linspace(0,1,1000);
omega_in_bandpass = pi;
cos_X = cos(200*pi*t);
figure
% subplot(121)
% plot(t,cos_X);
% title('x[n] Cosine with frequency in BandStop')
y_n = conv(cos_X,h_n,'same');
% subplot(122)
stem(t,y_n);
title('y[n] Cosine in bandstop Filtered')
ylim([-1 1])
% Frequency Domain Analysis: As the frequency of cosine is in the bandstop
% region of the Frequency Magnitude Response Filter, the cosine wave is
% filtered.
input('Part 6, press enter to continue')
%% Part 7: Magnitude Frequency Response in Decibels
figure
plot(omega,20*log10(magnitudeFreqResH)); 
title('Magnitude Frequency Response in dB')

% On Linear Scale:
% -10db = 0.3162
% -20db = 0.1
% -30db = 0.0316
% -40db = 0.01
input('Part 7, press enter to continue')
%% Part 8: Bandpass Shift
h_n_shifted_left = h_n.*exp(-1i*pi/2*n);
H_shfited_left = freqz(h_n_shifted_left,1,omega);
magnitudeFreqResH_left = abs(H_shfited_left);
h_n_shifted_right = h_n.*exp(1i*pi/2*n);
H_shfited_right = freqz(h_n_shifted_right,1,omega);
magnitudeFreqResH_right = abs(H_shfited_right);

indeces_om_left = find(omega<= 0);
indeces_om_right = find(omega > 0);
a = [magnitudeFreqResH_left(indeces_om_left),...
    magnitudeFreqResH_right(indeces_om_right)];

figure
subplot(121)
stem(n,h_n_shifted_left+h_n_shifted_right); 
title('Impulse Response With shifted bandpass centers at +/- pi/2')

subplot(122)
plot(omega,a); 
title('Frequency Response With shifted bandpass centers at +/- pi/2')
input('Part 8, press enter to continue')