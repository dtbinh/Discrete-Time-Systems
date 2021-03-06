function Hd = filter1
%FILTER1 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.3 and Signal Processing Toolbox 7.5.
% Generated on: 30-Oct-2018 17:41:02

% Equiripple Bandstop filter designed using the FIRPM function.

% All frequency values are normalized to 1.

Fpass1 = 0.09;            % First Passband Frequency
Fstop1 = 0.12;            % First Stopband Frequency
Fstop2 = 0.15;            % Second Stopband Frequency
Fpass2 = 0.2;             % Second Passband Frequency
Dpass1 = 0.028774368332;  % First Passband Ripple
Dstop  = 0.001;           % Stopband Attenuation
Dpass2 = 0.057501127785;  % Second Passband Ripple
dens   = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass1 Fstop1 Fstop2 Fpass2], [1 0 1], ...
                          [Dpass1 Dstop Dpass2]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);

% [EOF]
