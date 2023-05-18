clc
clf
% verified
clearvars
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = 0
qmax=1;
a1=0.9;
a2=39.39;
a3=-0.04;
a4=-0.7;
omega0=sqrt(a2);
tmax=1000;
time=0:0.01:tmax;
figure(1)
%  qddot = -a(1)*qdot - a(2)*q - a(3)*q^2 - a(4)*q^3  
%  x1=q   
%  x2=qdot
cf = -[a1 a2 a3 a4];
ode=@(t,w_h)[w_h(2);cf(1)*w_h(2)+cf(2)*w_h(1)+cf(3)*w_h(1)^2+cf(4)*w_h(1)^3];
[t,w_h]=ode45(ode, [0 tmax],[qmax 0]);
plot(w_h(:,1),w_h(:,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MMS  q=q0+q1
func = @(x) x^3-16*a3/(3*a4)*x^2+(32*a2/a4)*x-(32*a2/a4)*qmax;
x0 = 0; % starting point
c1 = fzero(func,x0)
test=c1^3-16*a3/(3*a4)*c1^2+(32*a2/a4)*c1-(32*a2/a4)*qmax
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=c1*exp(-a1*time/2);
beta=c1^2*time*3*a4/(8*omega0);
A=(a/2).*exp(i*beta);
Abar=(a/2).*exp(-i*beta);
q=-(2*a3*A.*Abar)/a2+...
     A.*exp(i*omega0*time)+...
    (a4*A.^3)/(8*a2).*exp(i*3*omega0*time)+...
     a3*A.^2/(3*a2).*exp(i*2*omega0*time)+...
     Abar.*exp(-i*omega0*time)+...
    (a4*Abar.^3)/(8*a2).*exp(-i*3*omega0*time)+...
     a3*Abar.^2/(3*a2).*exp(-i*2*omega0*time);
plot(t,w_h(:,1),'g',time,q,'b--o');


%ylim([-2 2])


