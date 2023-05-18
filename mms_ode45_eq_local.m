clc
clf
clearvars
%  qddot + a(2)*q + a(4)*q^3  = 0
a2=0.00213885027;
a4=-0.00016892606;
omega0=sqrt(a2);
qmax=0.1;
tmax=1000;
time=0:0.01:tmax;
delta1=(3*a4)/(96*a2^2);
const=qmax;
dum1=(12*sqrt(3)*sqrt(27*const^2*delta1^2+4*delta1)*delta1+108*const*delta1^2)^(1/3)/delta1;
dum2=(3*delta1)/(delta1*(12*sqrt(3)*sqrt(27*const^2*delta1^2+4*delta1)*delta1+108*const*delta1^2)^(1/3));
c1=(1/6)*dum1-(2/3)*dum2;
%c1=-(1/12)*dum1+(1/3)*dum2-(1/3)*delta2/delta1+(1/2*i)*sqrt(3)*((1/6)*dum1+(2/3)*dum2);
%c1=-(1/12)*dum1+(1/3)*dum2-(1/3)*delta2/delta1-(1/2*i)*sqrt(3)*((1/6)*dum1+(2/3)*dum2);
a=c1;
beta=(c1^2*time*3*a4)/(8*omega0);
A=(a/2).*exp(i*beta);
Abar=(a/2).*exp(-i*beta);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q0=A.*exp(i*omega0*time)+Abar.*exp(-i*omega0*time);
q1=0;
q2=(a4.*A.^3/(8*a2^2)).*exp(3*i*omega0*time)+(a4.*Abar.^3/(8*a2^2)).*exp(-3*i*omega0*time);
q=q0+q1+q2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
plot(time,q)
hold on
%  qddot = -a(1)*qdot - a(2)*q - a(3)*q^2 - a(4)*q^3 -a(5)  
%  x1=q   
%  x2=qdot
coeffs = -[ a2 a4];
ode=@(t,w_h)[w_h(2);coeffs(1)*w_h(1)+coeffs(2)*w_h(1)^3];

[t,w_h]=ode45(ode, [0 tmax],[qmax 0]);

plot(t,w_h(:,1));


