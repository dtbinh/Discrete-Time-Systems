x=[1 2 3 4 5]

X=fft(x,128)

figure(1)
subplot(211)
stem(x)
xlabel('n')
ylabel('x[n]')

subplot(212)
stem(abs(X))
xlabel('k')
ylabel('|X(k)|')