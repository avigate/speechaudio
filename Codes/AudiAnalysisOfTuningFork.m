%Author:Avinash Ithape
%mail ID: avigate @ gmail.com
% Select the WAV file from browse option after running this code
%The actual frequency of WAV file will be shown in subplot
%If any deviation in the frequency shown in the subplot,which means there
%is a deviation in manufacturing process of tuning fork.
%Example here though 1024.wav is recorded from the tuning fork having 1024
%as a specification. In FFT spectrum it can be analized  that its producing
%frequency of 560-600Hz only ,hence it is the defect
%This is tested using Matlab2014A


clc;
clear all;
[FileN,Path]=uigetfile('*.wav');
FileName=[Path FileN];
[p1,fs]=wavread(FileName);
%  

Fs = 48000;     % Sampling frequency
T = 1/Fs;       % Sample time
L = 1000;       % Length of signal
t = (0:L-1)*T;  % Time vector
  
figure,subplot(2,2,1),plot(p1);
title(strcat('Original WAV file',FileN));

%Take only 1000 samples of each audio file 
p1=p1(30600:31600);

subplot(2,2,2),plot(p1);
% TitleVal=strcat('Frequency = ',num2str());
title('Selected sample from WAV file');

%play the audio
sound(p1,48000);

%Take only one sided spectrum by using fft shift
fftm=fftshift(fft(p1));

magfft= real(fftm).*real(fftm);
subplot(2,2,3),plot(magfft);
title('Symmetrical FFT spectrum of audio file');

%select the order of FFT
% NFFT = 2^nextpow2(L); % Next power of 2 from length of y
  NFFT=2048;

Y = (fft(p1,NFFT));

f=0:Fs/NFFT:Fs;

%Map the frequency from the spectrum to actual frequency using sample
%rate-48Khz
freq=(find(abs(real(Y))> 0.8*max(abs(real(Y(:)))))-1);

TuningForkFrequqncy =freq(1)*48000/NFFT;

subplot(2,2,4),plot(f(1:NFFT),abs(real(Y)));
TitleVal=strcat('Frequency = ',num2str(TuningForkFrequqncy));
title(strcat('FFT shift of  audio',TitleVal));


          