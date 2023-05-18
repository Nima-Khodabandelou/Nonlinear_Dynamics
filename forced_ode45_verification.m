clc
clf
clearvars
clf(figure(1))
tmax=1000;
cf=-[0 254 0 -3.6];
zigma=-1:0.1:5;
omega0=sqrt(-cf(2));
f=1;
OMEGA=omega0+zigma(11);
ode=@(t,w_h)[w_h(2);cf(2)*w_h(1)+cf(3)*w_h(1)^3+cf(4)*w_h(1)^3+f*cos(OMEGA*t)];
[t,w_h]=ode45(ode, [0 tmax],[1 0]);
plot(t,w_h(:,1));
%%
maxamp=zeros(size(zigma,2),1);
for i=1:size(zigma,2)
    OMEGA=omega0+zigma(i);
    ode=@(t,w_h)[w_h(2);cf(2)*w_h(1)+cf(3)*w_h(1)^3+cf(4)*w_h(1)^3+f*cos(OMEGA*t)];
    [t,w_h]=ode45(ode, [0 tmax],[0 0]);
    lb=round(size(t,1)/10);
    ub=size(t,1);
    maxamp(i)=max(w_h(lb:ub,1));
end
%%
clf(figure(2))
plot(zigma,maxamp')
hold on
dx=zeros(1,6);
dy=[0 0.1 0.3 0.6 1 2];
plot(dx,dy);
a1=-cf(1);
a2=-cf(2);
a3=-cf(3);
a4=-cf(4);
%clf(figure(3))
a=0.1:0.001:2;
delta=(9*a4*omega0^2-10*a3^2)/(24*omega0^3);
zig1=delta*a.^2+sqrt(((f/(2*omega0))^2-((1/2).*a*a1).^2)./a.^2);
plot(zig1,a+0.1);
hold on
zig2=delta*a.^2-sqrt(((f/(2*omega0))^2-((1/2).*a*a1).^2)./a.^2);
plot(zig2,a+0.1);
hold on
