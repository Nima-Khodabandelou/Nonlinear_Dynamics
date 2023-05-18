clc
clf
clearvars
%  qddot + a(1)*qdot + a(2)*q = a(3)*q^2 + a(4)*q^3 = 0
a1=0.001;
a2=2;
a3=0.01;
a4=4;
omega0=sqrt(a2);
qmax=0.3;
time=0:0.01:20;
delta1=2*a3/(3*a2);
delta2=(2*a3^2)/(3*a2);
dum1=(12*sqrt(3)*sqrt(27*delta1^2*qmax^2-4*delta2^3*qmax+18*delta1*delta2*qmax-delta2^2+4*delta1)*delta1+108*qmax*delta1^2-8*delta2^3+36*delta2*delta1)^(1/3)/delta1;
dum2=(-delta2^2+3*delta1)/(delta1*(12*sqrt(3)*sqrt(27*delta1^2*qmax^2-4*delta2^3*qmax+18*delta1*delta2*qmax-delta2^2+4*delta1)*delta1+108*qmax*delta1^2-8*delta2^3+36*delta2*delta1)^(1/3));
c1=(1/6)*dum1-(2/3)*dum2-(1/3)*delta2/delta1;
%c1=-(1/12)*dum1+(1/3)*dum2-(1/3)*delta2/delta1+(1/2*i)*sqrt(3)*((1/6)*dum1+(2/3)*dum2);
%c1=-(1/12)*dum1+(1/3)*dum2-(1/3)*delta2/delta1-(1/2*i)*sqrt(3)*((1/6)*dum1+(2/3)*dum2);
a=c1*exp(-a1*time/2);
beta=(c1^2*time*(9*a4*omega0^2-10*a3^2))/(24*omega0^3);
A=(a/2).*exp(i*beta);
Abar=(a/2).*exp(-i*beta);
q0=A.*exp(i*omega0*time)+Abar.*exp(-i*omega0*time);
q1=-2*a3.*A.*Abar/a2+(a3.*A.^2/(3*a2)).*exp(2*i*omega0*time)+(a3.*Abar.^2/(3*a2)).*exp(-2*i*omega0*time);
q2=((3*a4+2*a3^2).*A.^3/(24*a2^2)).*exp(3*i*omega0*time)+((3*a4+2*a3^2).*Abar.^3/(24*a2^2)).*exp(-3*i*omega0*time);
q=q0+q1+q2;
figure(1)
plot(time,q)
hold on
%  qddot = a(1)*qdot+a(2)*q+a(3)*q^2+a(4)*q^3  
%  x1=q   
%  x2=qdot
coeffs = -[0.001 2 0.01 4];
ode=@(t,w_h)[w_h(2);
                   coeffs(1)*w_h(2)+coeffs(2)*w_h(1)+...
                   coeffs(3)*w_h(1)^2+coeffs(4)*w_h(1)^3];

[t,w_h]=ode45(ode, [0 20],[qmax 0]);

plot(t,w_h(:,1));


