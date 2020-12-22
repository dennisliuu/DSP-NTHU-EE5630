clear all; close all;
%%
n = -200:200;
n_d = 0;
h = sin(pi/8*n)./(pi*n) + 2/3*(-1).^n.*sin(3/8*pi*n)./(pi*n) + 1/3*(-1).^n.*sin(7/8*pi*n)./(pi*n);
figure;
plot(h)
%%
clc;clear all;
n=-200:1:200;
h1=(1/(2*pi))*((exp(j*pi*n/8))-1)./(j*n);
h2=(1/(2*pi))*(2/3)*((exp(j*5*pi*n/8))-(exp(j*3*pi*n/8)))./(j*n);
h3=(1/(2*pi))*(1/3)*((exp(j*pi*n))-(exp(j*7*pi*n/8)))./(j*n);
h=h1+h2+h3;
h(1,201)=1/6
w=0:(pi/1000):pi;
[H,w]=freqz(h,1,w);
figure;
plot(w/pi,abs(H),'r')