% Sampling rate reduction by sample repeating ***
% John Vanderkooy
% Material for CS489/W2016 Lecture 11, "Sampling"
%  
clear all; clc;close all;
disp('----------------start of program--------------------')
set(0,'DefaultLineLinewidth',1.5)
set(0,'DefaultAxesFontSize',12)
set(0,'DefaultAxesFontWeight','bold')
set(0,'DefaultAxesLineWidth',1.5)
%
try
pkg load signal %for Octave
catch
end
filename='HeyMister.wav';
%filename='ToccataAndFugue.wav';
%filename='FlaxenHair.aiff';
[MM,fs]=audioread(filename); %wavread(filename);% M is scaled to unity
M=MM(:,1);
N=length(M);
if N/2 > floor(N/2);M=M(1:2*floor(N/2));N=2*floor(N/2);end% makes it even
disp(['fs: ' num2str(fs) '  N: ' num2str(N) '  duration: ' num2str(N/fs)])
t=linspace(0,(N-1)/fs,N)';%column vector
disp('wait 3 sec to hear the plotted audio examples')
delay=3;
%------------------------------------------------
ns=15;% repeat number of samples
if ns<1;ns=1;end
%-------------------------
figure(10)
plot(t,M,'b') 
grid on;
axis([0 N/fs -1 1])
xlabel('time[s]')
legend('original')
title('Original')
pause(delay)

P=[M M];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)

%--------------------------------------
Mr=M;% initialize to size all arrays
Mf=M;
Mfr=M;
Mrf=M;
Mfrf=M;
%----------------original repeat sample reduced----------- 
%causes aliases and image problems
for k=1:ns:N-ns
    Mr(k:k+ns-1)=sum(M(k:k+ns-1))/ns;
end
%-----------------------------------------------
figure(15)
plot(t,Mr,'b')
grid on;
axis([0 N/fs -1 1])
%axis([0 N -1.5 1.5])
xlabel('time[s]')
legend('sample reduced unfiltered')
title(['original reduced by:' num2str(ns) ])
pause(delay)

P=[Mr Mr];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)

%---------------------original filtered then reduced-------------
%avoids aliases, but has spectral HF additive
[b,a]=butter(3,1.0/ns);
Mf=filtfilt(b,a,M);% linear phase filtering

for k=1:ns:N-ns
    Mfr(k:k+ns-1)=sum(Mf(k:k+ns-1))/ns;
end

figure(20)
plot(t,Mf,'b')
grid on;
axis([0 N/fs -1 1])
%axis([0 N -1.5 1.5])
xlabel('time[s]')
legend('filtered then reduced')
title(['filtered then reduced by:' num2str(ns)])
pause(delay)

P=[Mfr Mfr];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)

%---------------------original reduced then filtered-------------
%this one produces aliases but the postfiltering seems good overall

[b,a]=butter(3,1.0/ns);
Mrf=filtfilt(b,a,Mr);% linear phase filtering

figure(25)
plot(t,Mrf,'b')
grid on;
axis([0 N/fs -1 1])
%axis([0 N -1.5 1.5])
xlabel('time[s]')
legend('reduced then filtered')
title(['reduced by:' num2str(ns) ' then filtered'])
pause(delay)

P=[Mrf Mrf];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)
%----------------original filtered-reduced-filtered------------
%this should be reasonable, avoids aliases, but of course bandwidth is down
%start with filtered Mf and reduce it

for k=1:ns:N-ns
    Mfr(k:k+ns-1)=sum(Mf(k:k+ns-1))/ns;
end

Mfrf=filtfilt(b,a,Mfr);% linear phase filtering

figure(30)
plot(t,Mfrf,'b')
grid on;
axis([0 N/fs -1 1])
%axis([0 N -1.5 1.5])
xlabel('time[s]')
legend('filt-reduced-filt')
title(['filtered-reduced by:' num2str(ns) ' then final filter'])
pause(delay)

P=[Mfrf Mfrf];
player=audioplayer(P,fs);
playblocking(player); %wavplay(P,fs)

%-------------------spectral plots (slow in Octave...)-----------------------
f=([1:N/2+1]-1)*fs/N;
f(1)=1e-10;% prevents log plot error
S=fft(M);
Sr=fft(Mr);
Sfr=fft(Mfr);
Srf=fft(Mrf);
Sfrf=fft(Mfrf);

figure(100);
semilogx(f,20*log10(abs(S(1:N/2+1))),'b');
grid on;hold on
semilogx(f,20*log10(abs(Sr(1:N/2+1))),'r');
semilogx(f,20*log10(abs(Sfr(1:N/2+1))),'g');
semilogx(f,20*log10(abs(Srf(1:N/2+1))),'c');
semilogx(f,20*log10(abs(Sfrf(1:N/2+1))),'k');
axis([1 fs/2 -40 90])
legend('original','reduced','filt-reduced','reduced-filt','filt-red-filt')
xlabel('frequency [Hz]');ylabel('dB')
title(['Spectra']);
%---------------------------------------
Sm=pwroctsmooth(S,0.1);
Srm=pwroctsmooth(Sr,0.1);
Sfrm=pwroctsmooth(Sfr,0.1);
Srfm=pwroctsmooth(Srf,0.1);
Sfrfm=pwroctsmooth(Sfrf,0.1);
 
figure(200);
semilogx(f,20*log10(abs(Sm(1:N/2+1))),'b');
grid on;hold on
semilogx(f,20*log10(abs(Srm(1:N/2+1))),'r');
semilogx(f,20*log10(abs(Sfrm(1:N/2+1))),'g');
semilogx(f,20*log10(abs(Srfm(1:N/2+1))),'c');
semilogx(f,20*log10(abs(Sfrfm(1:N/2+1))),'k');
axis([1 fs/2 -40 90])
legend('original','reduced','filt-reduced','reduced-filt','filt-reduced-filt')
xlabel('frequency [Hz]');ylabel('dB')
title(['Smoothed Spectra']);

disp('-------------------finished--------------------') 
