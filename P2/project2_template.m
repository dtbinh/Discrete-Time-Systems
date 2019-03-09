% % this program demonstrates sampling and reconstruction
% % Tanja Karp 10-08-2018
% clc;clear;close all;
% 
% fs1=22.5*10^3;           % pick sampling rate supported by sound card, 
%                     % typically 8 kHz, 11.025 kHz, 22.05 kHz, 44.1 kHz, 48 kHz, 96 kHz
% nBits=16;           % bits per sample for quantization
% nChannels=1;        % choose 1 for mono, 2 for stereo
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % create sequence from 4 seconds of recorded voice
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('press any key to start voice recording')
% pause
% 
% % Record your voice for 4 seconds.
% recObj = audiorecorder(fs1,nBits,nChannels);
% disp('Start speaking.')
% recordblocking(recObj, 4);
% disp('End of recording.');
% x = getaudiodata(recObj);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % play recorded sequence
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sound(x,fs1,nBits)
% pause(4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% create wav-file from discrete-time sequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fs2=fs1/2;
% audiowrite('my_message_half.wav',x,fs2)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% read in wav-file 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % t = linspace(0,4,length(x));
% clc; clear;
% nBits=16; 
% filename1='my_message_orig.wav';
% filename2='my_message_twice.wav';
% filename3='my_message_half.wav';
% 
% [x1,fs1]=audioread(filename1);
% t = linspace(0,4,length(x1));
% sound(x1,fs1,nBits)
% pause(4)
% subplot(131);
% plot(t,x1);
% 
% [x2,fs2]=audioread(filename2);
% sound(x2,fs2,nBits)
% pause(4)
% subplot(132);
% plot(t,x2);
% 
% [x3,fs3]=audioread(filename3);
% sound(x3,fs3,nBits)
% pause(4)
% subplot(133);
% plot(t,x3);

%% Chirp Recording
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; clear; close all;
nBits=16;           % bits per sample for quantization
nChannels=1;        % choose 1 for mono, 2 for stereo

orig_sampling_freq = 48000;

disp('press any key to start voice recording')
pause

recObj = audiorecorder(orig_sampling_freq,nBits,nChannels);
disp('Start speaking.')
recordblocking(recObj, 20);
disp('End of recording.');
bird_chirp = getaudiodata(recObj);

sound(bird_chirp,orig_sampling_freq,nBits)
pause(4)

%% Save Chirp Recording
sf1 = 44.1e3;
sf2 = 22.05e3;
sf3 = 11.025e3;

sf5 = 48e3;
sf6 = 24e3;
sf7 = 8e3;

audiowrite('chirp_44_1.wav',bird_chirp,sf1);
audiowrite('chirp_22_05.wav',bird_chirp,sf2);
audiowrite('chirp_11_025.wav',bird_chirp,sf3);

audiowrite('chirp_48.wav',bird_chirp,sf4);
audiowrite('chirp_24.wav',bird_chirp,sf5);
audiowrite('chirp_8.wav',bird_chirp,sf6);

function rec_obj_file =  record_sig(file, sf, file_recording_name)
    nBits=16;           % bits per sample for quantization
    nChannels=1;        % choose 1 for mono, 2 for stereo

    orig_sampling_freq = 48000;

    disp('press any key to start voice recording')
    pause

    recObj = audiorecorder(orig_sampling_freq,nBits,nChannels);
    disp('Start speaking.')
    recordblocking(recObj, 20);
    disp('End of recording.');
    bird_chirp = getaudiodata(recObj);
end

