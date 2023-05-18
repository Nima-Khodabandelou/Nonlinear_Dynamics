clc
%  verified with: strainenergy_type2_cpt_uneg_ver2_local_noimperfect_resultants
clf
clearvars
%  qddot + a(2)*q + a(4)*q^3  = 0
qmax=1;
a2=639;
a4=-0.07;
omega0=sqrt(a2);
tmax=3;
time=0:0.01:tmax;
figure(1)
%  qddot = -a(1)*qdot - a(2)*q - a(3)*q^2 - a(4)*q^3 -a(5)  
%  x1=q   
%  x2=qdot
coeffs = -[ a2 a4];
ode=@(t,w_h)[w_h(2);coeffs(1)*w_h(1)+coeffs(2)*w_h(1)^3];
[t,w_h]=ode45(ode, [0 tmax],[qmax 0]);
%plot(t,w_h(:,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q=qmax*cos((omega0+(3*a4*qmax^2)/(8*omega0))*time);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%hold on
plot(t,w_h(:,1),'g',time,q,'b--o');
%xlim([0 5])
ylim([-2 2])