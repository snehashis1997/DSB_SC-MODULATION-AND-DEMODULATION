close all;

% modulation 

%define a messege signal 
fs=1000;
t=0:1/fs:1;
fm=4;
fc=50;
tc=0:1/fc:1;
m=cos(2*pi*fm*t);

%define a carrier signal
c=cos(2*pi*fc*t + 2*pi);
%figure,plot(t,c,'k') ;
% title('carrier signal');

%define the modulation
x=m.*c;

subplot(1,3,1);
plot(t,m,'g') ;
grid on;
title('messege signal');
subplot(1,3,2);
plot(t,c,'r') ;
grid on;
title('carrier signal');
subplot(1,3,3);
plot(t,x,'b') ;
grid on;
title('modulted dsb-sc signal');

n=length(m);
f=fs*[-n/2+2:n/2+1]/n;

%messge signal fft
messege_fft=fftshift(fft(x,n));
%figure,plot(f,abs(messege_fft));
dsb_fft=fftshift(fft(x,n));
carr_fft=fftshift(fft(c,n));

% figure,plot(t,x,'b') ;
title('dsb-sc signal');
figure;
subplot(1,3,1);
plot(f,abs(messege_fft),'r') ;
grid on;
title('abs value of fft messege signal');
subplot(1,3,2);
plot(f,abs(dsb_fft),'m') ;
grid on;
title('fourier transfrom of dsb sc signal');

subplot(1,3,3);
plot(f,abs(carr_fft),'k') ;
grid on;
title('fourier transfrom of carrier signal');


%demodulation
z=2*x.*c;
demodu_fft=fftshift(fft(x,n));
figure;
subplot(1,3,1);
plot(f,abs(demodu_fft));
grid on;
title('demodulation fft');

% finding error in messege signal before modulation and after demodulation
error=abs(messege_fft - demodu_fft);

% applying a butterworth filter of degree 5
[num,den]=butter(5,4.*fm/fs);
rec=filter(num,den,z);

subplot(1,3,2);
plot(f,(rec),'m');
grid on;
title('low pass amplitude');

%fft of filter output
rec_fft=fftshift(fft(rec,n));
subplot(1,3,3);
plot(f,abs(rec_fft),'r');
grid on;
title('low pass fft');

figure,plot(f,error);
grid on;
title('error in frequency domain');















