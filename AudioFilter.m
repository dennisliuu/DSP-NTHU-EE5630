%% An example of noise removal from an audio file
clear all;
close all;
clc;
%% Read in the file
[f, Fs] = audioread('online_filter.wav');
% f = f(:,2);
T = 1 / Fs;             % Sampling period
L = length(f);          % Length of signal
t = (0:L-1) * T;        % Time vector
%% Plot audio channels
N = size(f, 1);
figure;  stem(t, f);
title('Original: Time-domain');  xlabel('time(seconds)');
%% Plot the spectrum
df = Fs / N;
w = (-(N/2):(N/2)-1)*df;
y = fft(f) / N;         % For normalizing
y2 = fftshift(y);
figure;  plot(w, abs(y2));
title('Original: Amplitude Spectrum');  xlabel('Frequency(Hz)');

%% plot the single-sided amplitude spectrum
figure;
plot(Fs*(0:(L/2))/L, abs(y2(N/2:end)))
title('Original: Single-Sided Amplitude Spectrum')
xlabel('f (Hz)')

%% find f1
[fmax1, f1index] = max(abs(y2(N/2:end)));
fmax1, f1index = f1index*df

%% filtering 600
steps = 5;
for i = 1:steps
    n = 2;
    beginFreq = 590 / (Fs/2);
    endFreq = 610 / (Fs/2);
    [b,a] = butter(n, [beginFreq, endFreq], 'stop');
    fOut = filter(b, a, f);
    f = fOut;
    % extract f1
%     [b,a] = butter(n, [beginFreq, endFreq], 'bandpass');
%     f1 = filter(b, a, f);
%     figure;  plot(w,abs(fftshift(fft(f1)/N)));  title('f1: 1043Hz');
end
%% find f2
[fmax2, f2index] = max(abs(fftshift(fft(fOut)/N)));
fmax2, f2index = Fs/2 - f2index*df;
%% filtering 1800
for i = 1:steps
    n = 2;
    beginFreq = 1790 / (Fs/2);
    endFreq = 1810 / (Fs/2);
    [b,a] = butter(n, [beginFreq, endFreq], 'stop');
    fOut = filter(b, a, f);
    f = fOut;
    % extract f1
%     [b,a] = butter(n, [beginFreq, endFreq], 'bandpass');
%     f1 = filter(b, a, f);
%     figure;  plot(w,abs(fftshift(fft(f1)/N)));  title('f1: 1043Hz');
end
%% find f3
[fmax3, f3index] = max(abs(fftshift(fft(fOut)/N)));
fmax3, f3index = Fs/2 - f3index*df;
%% filtering 1200
for i = 1:steps
    n = 2;
    beginFreq = 1190 / (Fs/2);
    endFreq = 1210 / (Fs/2);
    [b,a] = butter(n, [beginFreq, endFreq], 'stop');
    fOut = filter(b, a, f);
    f = fOut;
    % extract f1
%     [b,a] = butter(n, [beginFreq, endFreq], 'bandpass');
%     f1 = filter(b, a, f);
%     figure;  plot(w,abs(fftshift(fft(f1)/N)));  title('f1: 1043Hz');
end
%% find f4
[fmax4, f4index] = max(abs(fftshift(fft(fOut)/N)));
fmax4, f4index = Fs/2 - f4index*df;
%% filtering 73
for i = 1:steps
    n = 2;
    beginFreq = 70 / (Fs/2);
    endFreq = 75 / (Fs/2);
    [b,a] = butter(n, [beginFreq, endFreq], 'stop');
    fOut = filter(b, a, f);
    f = fOut;
    % extract f1
%     [b,a] = butter(n, [beginFreq, endFreq], 'bandpass');
%     f1 = filter(b, a, f);
%     figure;  plot(w,abs(fftshift(fft(f1)/N)));  title('f1: 1043Hz');
end
%% find f5
[fmax5, f5index] = max(abs(fftshift(fft(fOut)/N)));
fmax5, f5index = Fs/2 - f5index*df;
%% filtering 250
for i = 1:steps
    n = 2;
    beginFreq = 245 / (Fs/2);
    endFreq = 250 / (Fs/2);
    [b,a] = butter(n, [beginFreq, endFreq], 'stop');
    fOut = filter(b, a, f);
    f = fOut;
    % extract f1
%     [b,a] = butter(n, [beginFreq, endFreq], 'bandpass');
%     f1 = filter(b, a, f);
%     figure;  plot(w,abs(fftshift(fft(f1)/N)));  title('f1: 1043Hz');
end
%% find f6
[fmax6, f6index] = max(abs(fftshift(fft(fOut)/N)));
fmax6, f6index = Fs/2 - f6index*df;
%% filtering 294
for i = 1:steps
    n = 2;
    beginFreq = 290 / (Fs/2);
    endFreq = 300 / (Fs/2);
    [b,a] = butter(n, [beginFreq, endFreq], 'stop');
    fOut = filter(b, a, f);
    f = fOut;
    % extract f1
%     [b,a] = butter(n, [beginFreq, endFreq], 'bandpass');
%     f1 = filter(b, a, f);
%     figure;  plot(w,abs(fftshift(fft(f1)/N)));  title('f1: 1043Hz');
end
%% For normalizing
Ym = max(max(max(fOut)),max(abs(min(fOut))));
fOut = fOut ./ Ym;

%% After processing
figure;  stem(t, fOut);
title('After processing: Time-domain');  xlabel('time(seconds)');
figure;  plot(w,abs(fftshift(fft(fOut)/N)));
title('After processing: Amplitude Spectrum');  xlabel('Frequency(Hz)');

%% Create object for playing audio
% pOrig = audioplayer(f,Fs);  % original signal
% pOrig.play;
% p = audioplayer(fOut, Fs);  % filtered signal
% p.play;
% pf1 = audioplayer(f1, Fs);  % noise: f1: 1043Hz
% pf1.play;
% pf2 = audioplayer(f2, Fs);  % noise: f2: 1956Hz
% % pf2.play;

%% Write out to audio file
audiowrite('Lisa_noise_processed.wav', fOut, Fs);
% audiowrite('f1.wav',f1,Fs);
% audiowrite('f2.wav',f2,Fs);
% audiowrite('f3.wav',f3,Fs);

