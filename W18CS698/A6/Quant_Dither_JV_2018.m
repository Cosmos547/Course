% Quantization & Dither Demo ***
% John Vanderkooy --- March 2018
% Material for CS489/W18 Lecture, "Quantization and Dither"
% the noise shaping calculation takes a while
clear all; clc;close all;
disp('----------------start of program--------------------')
set(0,'DefaultLineLinewidth',1.5)
set(0,'DefaultAxesFontSize',12)
set(0,'DefaultAxesFontWeight','bold')      
set(0,'DefaultAxesLineWidth',1.5)
format short
try
  pkg load signal% for Octave
catch   
end
%
%filename='DaltrySong1.wav';
filename='HeyMister.wav';
[MM,fs]=audioread(filename); %wavread(filename);% MM is scaled to unity
M=MM(:,1);% take left channel
N=length(M);
if N/2 > floor(N/2);M=M(1:2*floor(N/2));N=2*floor(N/2);end% makes it even
disp(['fs: ' num2str(fs) '  N: ' num2str(N) '  duration: ' num2str(N/fs)])
t=linspace(0,(N-1)/fs,N)';%column vector
disp('press a key to hear the plotted audio example')
disp('1:The first play is the undistorted 16-bit signal')
disp('2:Raw Quantization causes distortion, spitty silences, gross noise')
disp('3:RPDF dither removes distortion, but leaves the noise modulated')
disp('4:TPDF dither [2 randoms added] adds noise but removes the modulation')
disp('5:RPDF 1st-order noise shaping.  Less noise near DC more at HF')
disp('6:RPDF 1st-order noise shaping.  No dither, still a bit of modulation')
disp('7:dither added after quantization is useless!')
%------------------------------------------------
n_bit=3  ;%try 1, 2, 3, and 4
%----------------------------------------------------
% Create the dithers, scale (-1,1) range to n_bit quantization 
 
rpdf = (rand(N, 1) - 0.5)/2^(n_bit-1);  
tpdf = (rand(N, 1) - rand(N, 1))/2^(n_bit-1);  

%---------------------------------------------------
% Dithered Quantization by rounding

Mq=round(M*2^(n_bit-1))/(2^(n_bit-1));
Mqrpdf=round((M+rpdf)*2^(n_bit-1))/(2^(n_bit-1));
Mqtpdf=round((M+tpdf)*2^(n_bit-1))/(2^(n_bit-1));
% Dither added after rounding
Mqplus=round(M*2^(n_bit-1))/(2^(n_bit-1))+rpdf;

delay=2;

figure(10)
plot(t,M,'b')
grid on;
axis([0 N/fs -1 1])
xlabel('time[s]')
legend('1:original')
title('Original Signal')
pause (delay)

rms=sqrt(sum(M.^2)/N)
P=[M M];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)

%------------------------------

figure(15)
plot(t,Mq,'b')
grid on;
axis([0 N/fs -1 1])
xlabel('time[s]')
legend('2:quantized no dith')
title(['quantized to: ' num2str(n_bit) ' bits'])
pause (delay)

rms=sqrt(sum(Mq.^2)/N)
P=[Mq Mq];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)

%------------------------------------

figure(20)
plot(t,Mqrpdf,'b')
grid on;
axis([0 N/fs -1 1])
xlabel('time[s]')
legend('3:rpdf dithered')
title(['quantized to: ' num2str(n_bit) ' bits rpdf'])
pause (delay)

rms=sqrt(sum(Mqrpdf.^2)/N)
P=[Mqrpdf Mqrpdf];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)

%------------------------------

figure(25)
plot(t,Mqtpdf,'b')
grid on;
axis([0 N/fs -1 1])
xlabel('time[s]')
legend('4:tpdf dithered')
title(['quantized to: ' num2str(n_bit) ' bits tpdf'])
pause (delay)

rms=sqrt(sum(Mqtpdf.^2)/N)
P=[Mqtpdf Mqtpdf];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)

%--------------1st-order noise shaping with dither----------------
Mo=zeros(N,1);
Mi=Mo(1);
Mo(1)=round(Mi*2^(n_bit-1))/(2^(n_bit-1));
E=Mo(1)-Mi;
for k=2:N
    dith=(rand(1,1)-0.5)/2^(n_bit-1);
    E=Mo(k-1)-Mi;%error from last sample(k-1)
    Mi=M(k)-E;%new internal sum
    Mo(k)=round((Mi+dith)*2^(n_bit-1))/(2^(n_bit-1));
end
figure(30)
plot(t,Mo,'b')
grid on;
axis([0 N/fs -1 1])
xlabel('time[s]')
legend('5:rpdf 1st-order shaped')
title(['noise shaped to: ' num2str(n_bit) ' bits rpdf'])
pause (delay)

rms=sqrt(sum(Mo.^2)/N)
P=[Mo Mo];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)

%-----------------1st-order Noise Shaper, no dither-------
Mo=zeros(N,1);
Mi=Mo(1);
Mo(1)=round(Mi*2^(n_bit-1))/(2^(n_bit-1));
E=Mo(1)-Mi;
for k=2:N
    E=Mo(k-1)-Mi;%error from last sample(k-1)
    Mi=M(k)-E;%new internal sum
    Mo(k)=round(Mi*2^(n_bit-1))/(2^(n_bit-1));
end
figure(35)
plot(t,Mo,'b')
grid on;
axis([0 N/fs -1 1])
xlabel('time[s]')
legend('6:1st-order shaped no dith')
title(['noise shaped to: ' num2str(n_bit) ' bits no dith'])
pause (delay)

rms=sqrt(sum(Mo.^2)/N)
P=[Mo Mo];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)
 
%------------------------
figure(40)
plot(t,Mqplus,'b')
grid on;
axis([0 N/fs -1 1])
xlabel('time[s]')
legend('7:quantized then dither')
title(['quantized to: ' num2str(n_bit) ' bits, then dither'])
pause (delay)

rms=sqrt(sum(Mqplus.^2)/N)
P=[Mqplus Mqplus];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)

disp('-------------------finished--------------------') 
