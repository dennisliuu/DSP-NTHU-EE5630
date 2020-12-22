clc;clear all;




%
% Deltaw = Transition bandwidth (iteration variable)
%
N = 50; % Order of the filter
w0 = 0.5*pi; % Center frequency
Bandwidth = 0.02*pi; % Bandwidth
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






n = [0:1:200]; x = 2*cos(pi*n/2)+randn(1,201); y = filter(h,1,x);

Hf_1 = figure('Units','inches','position',[1,1,6,4],'paperunits','inches','paperposition',[0,0,6,4]);
set(Hf_1,'NumberTitle','off','Name','P7.34b');
subplot(2,1,1); 
Hs_1 = stem(n(101:201),x(101:201),'g','filled');
title('Input sequence x(n)','fontsize',10); 
set(Hs_1,'markersize',3);
ylabel('Amplitude','fontsize',10);
subplot(2,1,2); 
Hs_2 = stem(n(101:201),y(101:201),'m','filled');
title('Output sequence y(n)','fontsize',10); set(Hs_2,'markersize',3);
xlabel('n','fontsize',10); ylabel('Amplitude','fontsize',10);