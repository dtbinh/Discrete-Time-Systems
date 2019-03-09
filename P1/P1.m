% Tanja Karp
% Sample script to test system properties.
clearvars; close all; clc;

n = -4:4;
x = [0, 0, 0, 0, 1, 0, 0, 0, 0];
x1 = [0, 0, 0, 0, 0, 1, 0, 0, 0];
% x1 = [0, 0, 0, 0, 2, 0, 0, 0, 0];
% x1 = [0, 0, 0, 0, 0, 1, 1, 0, 0];

% x2 = [0, 0, 0, 0, 1, 0, 1, 0, 0];
x2= x+x1;
x3 = [0, 1, 1, 1, 1, 1, 1, 1, 0];

y = system1(x);
y1 = system1(x1);
y2 = system1(x2);
y3 = system1(x3);

subplot(421);
stem(n,x);
title('Input');
xlabel('n');
ylabel(strcat('x[n]= ', num2str(x)));
xlim([min(n)-0.5, max(n)+0.5]);
ylim([min(x)-0.5, max(x)+0.5]);

subplot(422);
stem(n,y(1:length(n)))
title('Output');
xlabel('n');
ylabel(strcat('y[n]= ', num2str(y)));
xlim([min(n)-0.5, max(n)+0.5]);
ylim([min(y)-0.5, max(y)+0.5]);

subplot(423);
stem(n,x1);
title('Input');
xlabel('n');
ylabel(strcat('x1[n]= ', num2str(x1)));
xlim([min(n)-0.5, max(n)+0.5]);
ylim([min(x1)-0.5, max(x1)+0.5]);

subplot(424);
stem(n,y1(1:length(n)))
title('Output');
xlabel('n');
ylabel(strcat('y1[n]= ', num2str(y1)));
xlim([min(n)-0.5, max(n)+0.5]);
ylim([min(y1)-0.5, max(y1)+0.5]);

subplot(425);
stem(n,x2);
title('Input');
xlabel('n');
ylabel(strcat('x2[n]= ', num2str(x2)));
xlim([min(n)-0.5, max(n)+0.5]);
ylim([min(x2)-0.5, max(x2)+0.5]);

subplot(426);
stem(n,y2(1:length(n)))
title('Output');
xlabel('n');
ylabel(strcat('y1[n]= ', num2str(y2)));
xlim([min(n)-0.5, max(n)+0.5]);
ylim([min(y2)-0.5, max(y2)+0.5]);

subplot(427);
stem(n,x3);
title('Input');
xlabel('n');
ylabel(strcat('x3[n]= ', num2str(x3)));
xlim([min(n)-0.5, max(n)+0.5]);
ylim([min(x3)-0.5, max(x3)+0.5]);

subplot(428);
stem(n,y3(1:length(n)))
title('Output');
xlabel('n');
ylabel(strcat('y3[n]= ', num2str(y3)));
xlim([min(n)-0.5, max(n)+0.5]);
ylim([min(y3)-0.5, max(y3)+0.5]);
