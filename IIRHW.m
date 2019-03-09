%% Mohak Kant, IIR HW

%% Part-1

% Clear system Values
clc; clear;

% Read in the audio file
[x,Fs] = audioread('noisy1.wav');

% Configuration of poles and zeros
r = 0.9214;
theta = 22.5; % in Deg
K=0.96198;

% a) Plot the Pole-Zero Response
polarscatter([theta*pi/180, -theta*pi/180],[r, r],100);
hold on
title('Poles and Zeros')
polarscatter([theta*pi/180, -theta*pi/180],[r-0.08, r-0.08],100,'x');

% b) Get the Numerator and Denominator coefficents with z^-2.
num_coef = K.*[1 -2*cosd(theta) 1];
den_coef = [1 -2*r*cosd(theta) r^2];
syms z;
num_pol = poly2sym(num_coef, z);
den_pol = poly2sym(den_coef, z);
disp(['Numerator Polynomial: ', num2str(num_coef(1)),'+',num2str(num_coef(2)),'z^-1','+',num2str(num_coef(3)),'z^-2']);
disp(['Denominator Polynomial: ', num2str(den_coef(1)),'+',num2str(den_coef(2)),'z^-1','+',num2str(den_coef(3)),'z^-2']);

% c) Plot Magnitude and Phase Response of the filter
[H,w] = freqz(num_coef,den_coef);
figure
plot(w/pi,20*log10(abs(H)));
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
title('Noisy 1 Bandstop Notch Filter Frequency Magnitude Response');
figure
plot(w/pi,(angle(H)*180/pi));
ylabel('Angle in Degree')
xlabel('Normalized Frequency (\times\pi rad/sample)')
title('Phase Response');

%% Part-2

% a) Filter the Data Using the coefficients obtained from the filter created
y = filter(num_coef,den_coef,x);

% b) Linear Difference Equation
y_2 = zeros(length(x),1);
for n = 3:length(x)
    y_2(n) = 0.96198*x(n)-1.777507265370415*x(n-1)+0.96198*x(n-2)+1.702525202511799*y_2(n-1)-0.84897796*y_2(n-2);
end

% c) The results are Identical.
difference_between_filtered_audios = floor(sum((y-y_2).^2)); % Take the Least Squared Error to measure distance
if difference_between_filtered_audios == 0
    disp('The results are Identical')
end

%% Part 3 - 

% The cut-off frequency or half-power frequency of a 
% digital filter is actually relative to the sampling 
% frequency fs. The pass band 
% is from 5% to 10% of fs. These ratios do not change if 
% fs changes to some other value. 
% The same digital filter will become a filter with 
% passband twice as much without us having to do anything.
% Since Speech is less than Fs/2=4kHz and the centeral 
% frequency being rejected is around 1kHz, the noise should still be filtered
% out. Also, the bandwidth and the centeral frequency of the filter would change
% if the sampling frequency is changed while designing the filter.

% So, basically in this case the frequencies being removed by the filter
% are in a narrower region, i.e the bandwidth of the bandreject region is
% narrower. 

% Also Practically, this code can be uncommented to load in a 8kHz speech
% signal and then filter it using the same filter and analyze the
% spectogram to notice the removed frequency. 

% audiowrite('noisy1_8khz.wav', x, 8000);
% 
% [x_8,Fs2]=audioread('noisy1_8khz.wav');
% y_8 = filter(num_coef,den_coef,x_8);
% signalAnalyzer(x_8,y_8)








