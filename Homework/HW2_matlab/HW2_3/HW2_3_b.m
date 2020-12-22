clc ;clear all;
wp = 150/500*pi; rp = 1;
ws = 100/500*pi; as = 40;
df = (wp-ws)/(pi*2);
d1 = (10^(rp/20)-1)/(10^(rp/20)+1);
d2 = (1+d1)*(10^(-as/20));
weights = [1,d2/d1];
M = ceil((-20*log10(sqrt(d1*d2))-13)/(14.6*df)+1);
M = 2*floor(M/2)+1;
m = [0,0,1,1];
f = [0,ws/pi,wp/pi,1];
h = remez(M-1,f,m,weights);
[H,w] = freqz(h,1,1000,'whole');
H = (H(1:1:501))'; w = (w(1:1:501))';
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
M = M+2;
h = remez(M-1,f,m,weights);
[H,w] = freqz(h,1,1000,'whole');
H = (H(1:1:501))'; w = (w(1:1:501))';
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
plot(w/pi,db);grid;title('Magnitude Response in dB');
xlabel('frequency in pi units'); ylabel('DECIBELS')

