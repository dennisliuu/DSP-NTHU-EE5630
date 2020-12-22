clc;clear all;
fs = 1000;
dt = 1/fs;
t = (0:300-1)*dt;
xa = 5*sin(200*pi*t)+2*cos(300*pi*t);
%%%%%%%%%%%%%%%%%%%%%%%%
wp = 150/500*pi; rp = 1;
ws = 100/500*pi; as = 40;
ripple = 10^(-rp/20); attn = 10^(-as/20);
fp =wp/(pi*2);fs =ws/(pi*2);
[N, wn] = cheb2ord(2*fp, 2*fs, rp, as);
[b, a] = cheby2(N, as, wn, 'high');
[c,b1,a1] = sdir2cas(b,a);
%%%%%%%%%%%%%%%%%%%%%%%%
d1 = (10^(rp/20)-1)/(10^(rp/20)+1);
d2 = (1+d1)*(10^(-as/20));
df = (wp-ws)/(pi*2);
weights = [1,d2/d1];
M = ceil((-20*log10(sqrt(d1*d2))-13)/(14.6*df)+1);
M = 2*floor(M/2)+1;
f = [0,ws/pi,wp/pi,1];
m = [0,0,1,1];
h = remez(M-1,f,m,weights);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[H,h_w] = freqz(b,a,1000,'whole');
H = (H(1:1:501))'; h_w = (h_w(1:1:501))';
h_mag = abs(H);
h_db = 20*log10((h_mag+eps)/max(h_mag));
h_pha = angle(H);
h_grd = grpdelay(b,a,h_w);
[xa_H,xa_w] = freqz(xa,1,1000,'whole');
xa_H = (xa_H(1:1:501))';xa_w = (xa_w(1:1:501))';
xa_mag = abs(xa_H);
xa_db = 20*log10((xa_mag+eps)/max(xa_mag));
xa_pha = angle(xa_H);
xa_grd = grpdelay(xa,1,xa_w);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ya = xa_mag.*h_mag.*exp(1i*h_pha+1i*xa_pha);
ya1 = [ya,conj(fliplr(ya(2:end)))];
ya2 = real(fftshift(ifft(ya1)));
subplot(2,1,1);
plot(ya2(200:499))
xlabel('discreate time')
title('IIR')
subplot(2,1,2);
plot(conv(xa,h,'same'));
xlabel('discreate time')
title('FIR ')


