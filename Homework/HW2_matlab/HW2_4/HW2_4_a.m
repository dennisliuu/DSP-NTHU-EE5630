clear; close all;
%% Specifications
N = 50; % Order of the filter
w0 = 0.5*pi; % Center frequency
Bandwidth = 0.02*pi; % Bandwidth
%
% Deltaw = Transition bandwidth (iteration variable)
%
wp1 = w0-Bandwidth/2; wp2 = w0+Bandwidth/2;
% (a) Design
Deltaw = 0.02*pi; % Initial guess
ws1=wp1-Deltaw; ws2=wp2+Deltaw;
F=[0, ws1, wp1, wp2, ws2, pi]/pi;
m=[0,0,1,1,0,0];
h=remez(50,F,m);
%%%%%%%%%%%%%%%%%%%
[H,w] = freqz(h,1,1000,'whole');
    H = (H(1:1:501))'; w = (w(1:1:501))';
  mag = abs(H);
   db = 20*log10((mag+eps)/max(mag));
  pha = angle(H);
%  pha = unwrap(angle(H));
  grd = grpdelay(h,1,w);
%%%%%%%%%%%%%%%%%%
%[db,mag,pha,grd,w]=freqz_m(h,1);
delta_w = pi/500;
Asd = floor(-max(db([1:floor(ws1/delta_w)]))), % Actual Attn

% Next iteration
Deltaw = Deltaw+0.01*pi;
ws1=wp1-Deltaw; ws2=wp2+Deltaw;
F=[0, ws1, wp1, wp2, ws2, pi]/pi;
h=remez(50,F,m);
%%%%%%%%%%%%%%%%%%%
[H,w] = freqz(h,1,1000,'whole');
    H = (H(1:1:501))'; w = (w(1:1:501))';
  mag = abs(H);
   db = 20*log10((mag+eps)/max(mag));
  pha = angle(H);
%  pha = unwrap(angle(H));
  grd = grpdelay(h,1,w);
%%%%%%%%%%%%%%%%%%
%[db,mag,pha,grd,w]=freqz_m(h,1);
delta_w = pi/500;
Asd = floor(-max(db([1:floor(ws1/delta_w)]))); % Actual Attn

% Next iterationDeltaw = Deltaw+0.01*pi;
ws1=wp1-Deltaw; ws2=wp2+Deltaw;
F=[0, ws1, wp1, wp2, ws2, pi]/pi;
h=remez(50,F,m);
%%%%%%%%%%%%%%%%%%%
[H,w] = freqz(h,1,1000,'whole');
    H = (H(1:1:501))'; w = (w(1:1:501))';
  mag = abs(H);
   db = 20*log10((mag+eps)/max(mag));
  pha = angle(H);
%  pha = unwrap(angle(H));
  grd = grpdelay(h,1,w);
%%%%%%%%%%%%%%%%%%
%[db,mag,pha,grd,w]=freqz_m(h,1);
delta_w = pi/500;
Asd = floor(-max(db([1:floor(ws1/delta_w)]))); % Actual Attn
% Next iteration
Deltaw = Deltaw+0.01*pi;
ws1=wp1-Deltaw; ws2=wp2+Deltaw;
F=[0, ws1, wp1, wp2, ws2, pi]/pi;
h=remez(50,F,m);
%%%%%%%%%%%%%%%%%%%
[H,w] = freqz(h,1,1000,'whole');
    H = (H(1:1:501))'; w = (w(1:1:501))';
  mag = abs(H);
   db = 20*log10((mag+eps)/max(mag));
  pha = angle(H);
%  pha = unwrap(angle(H));
  grd = grpdelay(h,1,w);
%%%%%%%%%%%%%%%%%%
%[db,mag,pha,grd,w]=freqz_m(h,1);
delta_w = pi/500;
Asd = floor(-max(db([1:floor(ws1/delta_w)]))); % Actual Attn

plot(w/pi,db,'g','linewidth',1.5); axis([0,1,-50,0]);
title('Log-Magnitude Response','fontsize',10);
xlabel('\omega/\pi','fontsize',10); ylabel('DECIBELS','fontsize',10)
set(gca,'XTick',[0;ws1/pi;ws2/pi;1],'YTick',[-30;0]);
set(gca,'YTickLabel',[30; 0 ]);grid