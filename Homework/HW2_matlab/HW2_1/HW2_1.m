close all; clear all;

%% parameters.
% analog
analog_fps = 1500;
analog_window_time = 10; %sec
t = 0:1/analog_fps: analog_window_time-1/analog_fps;

% digital
digital_fps = 5;
n = downsample(t,analog_fps/digital_fps);

% ADC: Quantizer
X_m = 1; % Range
B = 10;% Bit number.

%% Signal generation
freq_hz = 10; % Hz.
x_c = sin(pi*freq_hz*t.^2/10);

%% ADC
% Sampling
x_s = downsample(x_c,analog_fps/digital_fps);

% Quantizing (abs of input value should not over 1)
% x_d = Quantizing(x_s,B,X_m);  % A For complete ADC, a quantizing should
% be added here.
x_n = x_s; % For basic case, we skip the  quantizing here.

%% DAC
% up sample / DAC
x_up = upsample(x_n,analog_fps/digital_fps);

% LPF (Reconstruction Filters)
h = intfilt(analog_fps/digital_fps,4,0.9);
%% Important
% please not the parameter 0.9, ideally should be 1 for Nyquist rate.
% 0.9 here is ratio of Nyquist.
% Given known limit band signal, shourter ratio can enhance SNR by oversampling.
%  (i,e, here I filterout the freq larger than 2.5(Nyquist rate) * 0.9 = 2.25Hz)

y_r = filter(h,1,x_up);
y_r(1:floor(mean(grpdelay(h)))) = [];
y_r = [y_r zeros(1,floor(mean(grpdelay(h))))];


%% Display

figure;
plot(t,x_c);
hold on;
plot(n,x_n);
plot(t,y_r);
title('analog signal (1500Hz) v.s. digital signal (5Hz) v.s. Reconstructed signal (1500Hz)');
legend('x_c','x[n]','y_r');
