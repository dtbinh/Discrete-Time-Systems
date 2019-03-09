%% IIR in class activity
% Mohak Kant
% 10th November, 2018

clc; clear; close all;

%% Define Filter Design Paramaters
Fs = 16000; 
N  = 2;   
Fc = 120;  
h  = fdesign.highpass('N,F3dB', N, Fc, Fs);

%% Construct the Data
fs = 2000;
n = 0:1/fs:1-1/fs;
x = [zeros(1,200) (1:800)/800 zeros(1,1000)];
x = x + 0.3*sin(2*pi*120*n) + 0.1*randn(1,2000);
figure(1);
plot(n,x);
xlabel('time');
ylabel('amplitude');

%% Find the z-angle and the p-angle
z_angle = 120/fs*2*pi;
z1_2 = [exp(1i*z_angle);exp(-1i*z_angle)];
a = 20;
p_angle = a/fs*2*pi;
b = sqrt((1+1-2*cos(z_angle-p_angle)));
p_mag = 1 - b;
p_1 = [p_mag*exp(1i*z_angle);p_mag*exp(-1i*z_angle)];
figure(2);
zplane(z1_2,p_1);
grid


%% Get Co-efficients
Numerator   = [0.028 0.053 0.071 0.053 0.028];  % Numerator coefficient
                                                % vector
Denominator = [1 -2.026 2.148 -1.159 0.279];    % Denominator coefficient
                                                % vector
%% Creat the Filter
Hd = dfilt.df2t(Numerator, Denominator);

%% Plot the Impulse Response
[h_a,t_a] = impz(Numerator,Denominator);
figure(3)
plot(t_a, h_a);

%% Filter the Data
x_filt = conv2(x,h_a,'same');

