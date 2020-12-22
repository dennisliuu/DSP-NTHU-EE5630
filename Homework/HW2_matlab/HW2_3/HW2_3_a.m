clc ;clear all;
wp = 150/500*pi; rp = 1;
ws = 100/500*pi; as = 40;
ripple = 10^(-rp/20);
attn = 10^(-as/20);
fs =ws/(pi*2);
fp =wp/(pi*2);
[N, wn] = cheb2ord(2*fp, 2*fs, rp, as);
[b, a] = cheby2(N, as, wn, 'high');
[c,b1,a1] = sdir2cas(b,a);
[H,w] = freqz(b,a,1000,'whole');
H = (H(1:1:501))'; w = (w(1:1:501))';
mag = abs(H);
db = 20*log10((mag+eps)/max(mag));
plot(w/pi,db);grid;title('Magnitude in dB')
xlabel('frequency in pi units'); 
ylabel('decibels')

