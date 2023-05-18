clc
%  
clf
clearvars
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3 + a(5)*qdot*q + a(6)*qdot*q^2 + a(7)  = 0
qmax=1;
a1=0;
a2=6.3;
a3=-0.00072;
a4=0;
a5=0;
a6=0;
a7=0;
tmax=100;
time=0:0.01:tmax;
figure(1)
%  qddot = -a(1)*qdot - a(2)*q^2 - a(3)*q^3   
%  x1=q   
%  x2=qdot
cf = -[a1 a2 a3 a4 a5 a6];
ode=@(t,w_h)[w_h(2);cf(1)*w_h(2)+cf(2)*w_h(1)+cf(3)*w_h(1)^2+cf(4)*w_h(1)^3+cf(5)*w_h(2)*w_h(1)+cf(6)*w_h(2)*w_h(1)^2];
[t,w_h]=ode45(ode, [0 tmax],[qmax 0]);
%plot(t,w_h(:,1));
%ylim([-2 2])
plot(w_h(:,1),w_h(:,2));

 
% func = @(x) x^3-3.047619048*x^2-2.742857144*10^5*x+1.645714286*10^5;
% x0 = 0; % starting point
% roots = fzero(func,x0)