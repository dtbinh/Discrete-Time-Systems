[y1,Fs1] = audioread('noisy1.wav');
N      = 10;              % Order
Fpass1 = 0.09;            % First Passband Frequency
Fstop1 = 0.12;            % First Stopband Frequency
Fstop2 = 0.15;            % Second Stopband Frequency
Fpass2 = 0.2;             % Second Passband Frequency
Wpass1 = 0.028774368332;  % First Passband Weight
Wstop  = 0.001;           % Stopband Weight
Wpass2 = 0.0575011;       % Second Passband Weight
dens   = 20;              % Density Factor

% Calculate the coefficients using the FIRPM function.
h1  = firpm(N, [0 Fpass1 Fstop1 Fstop2 Fpass2 1], [1 1 0 0 1 1], ...
           [Wpass1 Wstop Wpass2], {dens});
y1_filt = conv(y1,h1,'same');
soundsc(y1_filt,Fs1);
% audiowrite('Noisy1_Filtered.wav',y1_filt,Fs1);
% sound(y1_filt, Fs1)