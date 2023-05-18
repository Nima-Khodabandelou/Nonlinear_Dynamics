clc
clf
% verified
clearvars
% qddot + a(1)*q  = 0
qmax=1;
a1=0.9;

tmax=1000;
time=0:0.01:tmax;

ode=@(t,w_h)[w_h(2);-a1*w_h(1)];
[t,w_h]=ode45(ode, [0 tmax],[qmax 0]);
plot(t,w_h(:,1));

