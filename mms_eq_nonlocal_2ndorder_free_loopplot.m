clc
clf
% verification with ode45 was not successful
clearvars  % OMEGA: excitation freq. in MMS -> OMEGA=omega0+eps*zigma
data=xlsread('data.xls');
for sel=1:size(data,1)
coeffs=data(sel,:);
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = f*cos(OMEGA*t)
f=1;
a1=coeffs(1,1);
a2=coeffs(1,2);
a3=coeffs(1,3);
a4=coeffs(1,4);
omega0=sqrt(a2);
eps=1;
tmax=100;
time=0:0.01:tmax;
figure(1)
%  qddot = -a(1)*qdot - a(2)*q - a(3)*q^2 - a(4)*q^3  
%  x1=q   
%  x2=qdot

a=0.005:0.001:0.2;
delta=(9*a4*omega0^2-10*a3^2)/(24*omega0^3);
zig1=delta*a.^2+sqrt(((f/(2*omega0))^2-((1/2).*a*a1).^2)./a.^2);
plot(zig1,a);
hold on
zig2=delta*a.^2-sqrt(((f/(2*omega0))^2-((1/2).*a*a1).^2)./a.^2);
plot(zig2,a);
hold on
end


