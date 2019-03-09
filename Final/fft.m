% Evaluation of DFT properties


w0=1/10*pi
N=100;

n=0:N-1;
x=cos(w0*n);

figure(1)
subplot(211)
stem(n,x);
xlabel('n')
ylabel('x[n]')

subplot(212)
stem(0:2*N-1,[x, x]);
xlabel('n')
ylabel('periodic x[n]')

X=fft(x);
k=0:N-1;

figure(2)
subplot(211)
stem(k,abs(X))
ylabel('|X[k]')
xlabel('k')

subplot(212)
stem(k,angle(X))
ylabel('phase(X[k])')
xlabel('k')
