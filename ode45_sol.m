clc
clear all
clf
%  qddot = a(1)*qdot+a(2)*q+a(3)*q^2+a(4)*q^3  
%  x1=q   
%  x2=qdot
coeffs = -[0.01 2 0.01 4];
ode=@(t,w_h)[w_h(2);
                   coeffs(1)*w_h(2)+coeffs(2)*w_h(1)+...
                   coeffs(3)*w_h(1)^2+coeffs(4)*w_h(1)^3*t];

[t,w_h]=ode45(ode, [0 200],[1 0]);
figure(1) 
plot(t,w_h(:,1));

%%%%%%%%%%%%%%%%%%%%% MMS Solution



