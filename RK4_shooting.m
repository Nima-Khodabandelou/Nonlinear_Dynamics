clc
clf
clearvars
%data=xlsread('data.xls');
%coeffs=data(4,:);
coeffs=[0 32 0 -3 0 0 0];
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3+ a(5)qdot*q + a(6)*qdot*q^2 +a(7) = f*cos(OMEGA*t)
f=1;
a1=coeffs(1,1);
a2=coeffs(1,2);
a3=coeffs(1,3);
a4=coeffs(1,4);
a5=coeffs(1,5);
a6=coeffs(1,6);
a7=coeffs(1,7);
omega0=sqrt(a2);
qmax=0.1;
tmax=200;
%  qddot = -a(1)*qdot - a(2)*q - a(3)*q^2 - a(4)*q^3 -a(5)  
%  x1=q   
%  x2=qdot
zigma=0;
period=2*pi/omega0;
omega=sqrt(a2);
cf = -[a1 a2 a3 a4 a5 a6 a7];
%defining x1=w, we have:
%d/dt(x1)=x2
%d/dt(x2)=x3
f1=@(t,x1,x2,x3,x4,x5,x6) x2;
f2=@(t,x1,x2,x3,x4,x5,x6) -a2*x1-a4*x1^3+f*cos(omega*t);
f3=@(t,x1,x2,x3,x4,x5,x6) x5;
f4=@(t,x1,x2,x3,x4,x5,x6) x6;
f5=@(t,x1,x2,x3,x4,x5,x6) -a2*x3-a4*3*x1^2*x3;
f6=@(t,x1,x2,x3,x4,x5,x6) -a2*x4-a4*3*x1^2*x4;
%

t(1)=0.1;x1(1)=0;x2(1)=0;x3(1)=1;x4(1)=0;x5(1)=0;x6(1)=1;
%
h=0.001;N=10000;
%
for i=1:N
   t(i+1)=t(i)+h; 
   
   k1x1=f1(t(i),x1(i),x2(i),x3(i),x4(i),x5(i),x6(i));
   k1x2=f2(t(i),x1(i),x2(i),x3(i),x4(i),x5(i),x6(i));
   k1x3=f3(t(i),x1(i),x2(i),x3(i),x4(i),x5(i),x6(i));
   k1x4=f4(t(i),x1(i),x2(i),x3(i),x4(i),x5(i),x6(i));
   k1x5=f5(t(i),x1(i),x2(i),x3(i),x4(i),x5(i),x6(i));
   k1x6=f6(t(i),x1(i),x2(i),x3(i),x4(i),x5(i),x6(i));
   
      
   k2x1=f1(t(i)+h/2,x1(i)+(h/2)*k1x1,x2(i)+(h/2)*k1x2,x3(i)+(h/2)*k1x3,x4(i)+(h/2)*k1x4,x5(i)+(h/2)*k1x5,x6(i)+(h/2)*k1x6);
   k2x2=f2(t(i)+h/2,x1(i)+(h/2)*k1x1,x2(i)+(h/2)*k1x2,x3(i)+(h/2)*k1x3,x4(i)+(h/2)*k1x4,x5(i)+(h/2)*k1x5,x6(i)+(h/2)*k1x6);   
   k2x3=f3(t(i)+h/2,x1(i)+(h/2)*k1x1,x2(i)+(h/2)*k1x2,x3(i)+(h/2)*k1x3,x4(i)+(h/2)*k1x4,x5(i)+(h/2)*k1x5,x6(i)+(h/2)*k1x6);
   k2x4=f4(t(i)+h/2,x1(i)+(h/2)*k1x1,x2(i)+(h/2)*k1x2,x3(i)+(h/2)*k1x3,x4(i)+(h/2)*k1x4,x5(i)+(h/2)*k1x5,x6(i)+(h/2)*k1x6);
   k2x5=f5(t(i)+h/2,x1(i)+(h/2)*k1x1,x2(i)+(h/2)*k1x2,x3(i)+(h/2)*k1x3,x4(i)+(h/2)*k1x4,x5(i)+(h/2)*k1x5,x6(i)+(h/2)*k1x6);
   k2x6=f6(t(i)+h/2,x1(i)+(h/2)*k1x1,x2(i)+(h/2)*k1x2,x3(i)+(h/2)*k1x3,x4(i)+(h/2)*k1x4,x5(i)+(h/2)*k1x5,x6(i)+(h/2)*k1x6);
   
   k3x1=f1(t(i)+h/2,x1(i)+(h/2)*k2x1,x2(i)+(h/2)*k2x2,x3(i)+(h/2)*k2x3,x4(i)+(h/2)*k2x4,x5(i)+(h/2)*k2x5,x6(i)+(h/2)*k2x6);
   k3x2=f2(t(i)+h/2,x1(i)+(h/2)*k2x1,x2(i)+(h/2)*k2x2,x3(i)+(h/2)*k2x3,x4(i)+(h/2)*k2x4,x5(i)+(h/2)*k2x5,x6(i)+(h/2)*k2x6);
   k3x3=f3(t(i)+h/2,x1(i)+(h/2)*k2x1,x2(i)+(h/2)*k2x2,x3(i)+(h/2)*k2x3,x4(i)+(h/2)*k2x4,x5(i)+(h/2)*k2x5,x6(i)+(h/2)*k2x6);
   k3x4=f4(t(i)+h/2,x1(i)+(h/2)*k2x1,x2(i)+(h/2)*k2x2,x3(i)+(h/2)*k2x3,x4(i)+(h/2)*k2x4,x5(i)+(h/2)*k2x5,x6(i)+(h/2)*k2x6);
   k3x5=f5(t(i)+h/2,x1(i)+(h/2)*k2x1,x2(i)+(h/2)*k2x2,x3(i)+(h/2)*k2x3,x4(i)+(h/2)*k2x4,x5(i)+(h/2)*k2x5,x6(i)+(h/2)*k2x6);
   k3x6=f6(t(i)+h/2,x1(i)+(h/2)*k2x1,x2(i)+(h/2)*k2x2,x3(i)+(h/2)*k2x3,x4(i)+(h/2)*k2x4,x5(i)+(h/2)*k2x5,x6(i)+(h/2)*k2x6);
   
   k4x1=f1(t(i)+h,x1(i)+ h*k3x1,x2(i)+h*k3x2,x3(i)+h*k3x3,x4(i)+h*k3x4,x5(i)+h*k3x5,x6(i)+h*k3x6);
   k4x2=f2(t(i)+h,x1(i)+ h*k3x1,x2(i)+h*k3x2,x3(i)+h*k3x3,x4(i)+h*k3x4,x5(i)+h*k3x5,x6(i)+h*k3x6);   
   k4x3=f3(t(i)+h,x1(i)+ h*k3x1,x2(i)+h*k3x2,x3(i)+h*k3x3,x4(i)+h*k3x4,x5(i)+h*k3x5,x6(i)+h*k3x6);
   k4x4=f4(t(i)+h,x1(i)+ h*k3x1,x2(i)+h*k3x2,x3(i)+h*k3x3,x4(i)+h*k3x4,x5(i)+h*k3x5,x6(i)+h*k3x6);
   k4x5=f5(t(i)+h,x1(i)+ h*k3x1,x2(i)+h*k3x2,x3(i)+h*k3x3,x4(i)+h*k3x4,x5(i)+h*k3x5,x6(i)+h*k3x6);
   k4x6=f6(t(i)+h,x1(i)+ h*k3x1,x2(i)+h*k3x2,x3(i)+h*k3x3,x4(i)+h*k3x4,x5(i)+h*k3x5,x6(i)+h*k3x6);
   
   x1(i+1)=x1(i)+(h/6)*(k1x1+2*k2x1+2*k3x1+k4x1);
   x2(i+1)=x2(i)+(h/6)*(k1x2+2*k2x2+2*k3x2+k4x2); 
   x3(i+1)=x3(i)+(h/6)*(k1x3+2*k2x3+2*k3x3+k4x3);
   x4(i+1)=x4(i)+(h/6)*(k1x4+2*k2x4+2*k3x4+k4x4);
   x5(i+1)=x5(i)+(h/6)*(k1x5+2*k2x5+2*k3x5+k4x5);
   x6(i+1)=x6(i)+(h/6)*(k1x6+2*k2x6+2*k3x6+k4x6);
end
%figure(2)
plot(t,x1)
