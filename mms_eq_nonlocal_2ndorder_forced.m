clc
clf
% verification with ode45 was not successful
clearvars  % OMEGA: excitation freq. in MMS -> OMEGA=omega0+eps*zigma
data=xlsread('data.xls');
sel=3;
coeffs=data(sel,:);
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = f*cos(OMEGA*t)
f=1;
a1=coeffs(1,1);
a2=coeffs(1,2);
a3=coeffs(1,3);
a4=coeffs(1,4);
omega0=sqrt(a2);
eps=1;
tmax=0.0001;
time=0:0.000001:tmax;
figure(1)
%  qddot = -a(1)*qdot - a(2)*q - a(3)*q^2 - a(4)*q^3  
%  x1=q   
%  x2=qdot
cf = -[a1 a2 a3 a4];
a=0.01:0.001:0.85;
delta=(9*a4*omega0^2-10*a3^2)/(24*omega0^3);
zig1=delta*a.^2+sqrt(((f/(2*omega0))^2-((1/2).*a*a1).^2)./a.^2);
plot(zig1,a);
hold on
zig2=delta*a.^2-sqrt(((f/(2*omega0))^2-((1/2).*a*a1).^2)./a.^2);
plot(zig2,a);
hold on
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MMS 
%%%%%%%%%%%%%% steady state solution
clf(figure(2))
mou=a1/2;
a=1;
zigma=2e-3;
u=a*cos((omega0+eps*zigma)*time-asin(2*mou*a*omega0/f));
plot(time,u);
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure(2)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf(figure(2))
k=1;
for f=-7:0.1:1  % here a is defined as x
func = @(x) x^6+(-2*zig1(3)/delta)*x^4+((a1^2+4*zig1(3)^2)/(4*delta^2))*x^2-(f^2/(4*a2*delta^2));
x0 = 0; % starting point
c1 = fzero(func,x0);
k=k+1;
a_f(k,1)=f;
a_f(k,2)=c1;
end
plot(a_f(:,1),a_f(:,2));

%%   ode45 time
clf(figure(2))
tmax=0.03;
eps=1;
zigma=[0 320000	384000	448000	512000	576000	640000	704000	768000	832000	896000	960000	1024000	1088000	1152000	1216000	1280000 1920000 3840000];
%zigma=0*omega0;
OMEGA=omega0+eps*zigma(11);
ode=@(t,w_h)[w_h(2);cf(1)*w_h(2)+cf(2)*w_h(1)+cf(3)*w_h(1)^2+cf(4)*w_h(1)^3+f*cos(OMEGA*t)];
[t,w_h]=ode45(ode, [0 tmax],[0 0]);
plot(t,w_h(:,1));
maxamp=zeros(size(zigma,2),1);
for i=1:size(zigma,2)
    OMEGA=omega0+eps*zigma(i);
    ode=@(t,w_h)[w_h(2);cf(1)*w_h(2)+cf(2)*w_h(1)+cf(3)*w_h(1)^2+cf(4)*w_h(1)^3+f*cos(OMEGA*t)];
    [t,w_h]=ode45(ode, [0 tmax],[0 0]);
    lb=round(size(t,1)/3);
    ub=size(t,1);
    maxamp(i)=max(w_h(lb:ub,1));
end
%%     backbone ode45
clf(figure(3))
k=1;
a_zigma=zeros(2,2);
for zigma=4:-0.1:0.001
    OMEGA=omega0+eps^2*zigma;
    ode=@(t,w_h)[w_h(2);cf(1)*w_h(2)+cf(2)*w_h(1)+cf(3)*w_h(1)^2+cf(4)*w_h(1)^3+f*cos(OMEGA*t)];
    [t,w_h]=ode45(ode, [0 tmax],[f 0]);
    a_zigma(k,1)=max(w_h(:,1));
    a_zigma(k,2)=zigma;
    k=k+1;
end
plot(a_zigma(:,2),a_zigma(:,1));
hold on
%%
k=1;
a_zigma2=zeros(2,2);
for zigma2=-20:1:-1
    OMEGA2=omega0+eps^2*zigma2;
    ode=@(t,w_h)[w_h(2);cf(1)*w_h(2)+cf(2)*w_h(1)+cf(3)*w_h(1)^2+cf(4)*w_h(1)^3+f*cos(OMEGA2*t)];
    [t,w_h]=ode45(ode, [0 tmax],[f 0]);
    a_zigma2(k,1)=max(w_h(:,1))-f;
    a_zigma2(k,2)=zigma2;
    k=k+1;
end
plot(a_zigma2(:,2),a_zigma2(:,1));




