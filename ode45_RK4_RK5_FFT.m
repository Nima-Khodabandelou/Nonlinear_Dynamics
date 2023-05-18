clc
clf
clearvars
%data=xlsread('data.xls');
%coeffs=data(4,:);
coeffs=[0 1 0 1 0 0 0];
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3+ a(5)qdot*q + a(6)*qdot*q^2 +a(7) = f*cos(OMEGA*t)
f=4;
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
zigma=0.3;
period=2*pi/omega0;
omega=2*pi/period+zigma;
cf = -[a1 a2 a3 a4 a5 a6 a7];
ode=@(t,w_h)[w_h(2);
                   cf(1)*w_h(2)+cf(2)*w_h(1)+...
                   cf(3)*w_h(1)^2+cf(4)*w_h(1)^3+...
                   cf(5)*w_h(2)*w_h(1)+cf(6)*w_h(2)*w_h(1)^2+cf(7)+f*cos(omega*t)];
[t,w_h]=ode45(ode, [0 tmax],[qmax 0]);
figure(1)
plot(t,w_h(:,1));
hold on
%%
%%%% coded RK4 for FFt
%defining x1=w, we have:
%d/dt(x1)=x2
%d/dt(x2)=x3
f1=@(t,x1,x2) x2;
f2=@(t,x1,x2) a1*x2+cf(2)*x1+...
              a3*x1^2+cf(4)*x1^3+...
              a5*x2*x1+a6*x2*x1^2+a7+f*cos(omega*t);
%
t(1)=0;x1(1)=0.1;x2(1)=0;
%
h=0.001;N=200000;
%
for i=1:N
   t(i+1)=t(i)+h; 
   
   k1x1=f1(t(i),x1(i),x2(i));
   k1x2=f2(t(i),x1(i),x2(i));
      
   k2x1=f1(t(i)+h/2,x1(i)+(h/2)*k1x1,x2(i)+(h/2)*k1x2);
   k2x2=f2(t(i)+h/2,x1(i)+(h/2)*k1x1,x2(i)+(h/2)*k1x2);   
   
   k3x1=f1(t(i)+h/2,x1(i)+(h/2)*k2x1,x2(i)+(h/2)*k2x2);
   k3x2=f2(t(i)+h/2,x1(i)+(h/2)*k2x1,x2(i)+(h/2)*k2x2);
   
   k4x1=f1(t(i)+h,x1(i)+ h*k3x1,x2(i)+h*k3x2);
   k4x2=f2(t(i)+h,x1(i)+ h*k3x1,x2(i)+h*k3x2);   
   
   x1(i+1)=x1(i)+(h/6)*(k1x1+2*k2x1+2*k3x1+k4x1);
   x2(i+1)=x2(i)+(h/6)*(k1x2+2*k2x2+2*k3x2+k4x2);   
end
%figure(2)
plot(t,x1)
%%
%%%% coded RK5 for FFt
%defining x1=w, we have:
%d/dt(x1)=x2
%d/dt(x2)=x3
f1=@(t,x1,x2) x2;
f2=@(t,x1,x2) a1*x2+cf(2)*x1+...
              a3*x1^2+cf(4)*x1^3+...
              a5*x2*x1+a6*x2*x1^2+a7+f*cos(omega*t);
%
t(1)=0;x1(1)=0.1;x2(1)=0;
%
h=0.001;N=200000;
%
for i=1:N
   t(i+1)=t(i)+h; 
   
   k1x1=f1(t(i),x1(i),x2(i));
   k1x2=f2(t(i),x1(i),x2(i));
      
   k2x1=f1(t(i)+h/2,x1(i)+(h/2)*k1x1,x2(i)+(h/2)*k1x2);
   k2x2=f2(t(i)+h/2,x1(i)+(h/2)*k1x1,x2(i)+(h/2)*k1x2);   
   
   k3x1=f1(t(i)+h/2,x1(i)+(h/2)*k2x1,x2(i)+(h/2)*k2x2);
   k3x2=f2(t(i)+h/2,x1(i)+(h/2)*k2x1,x2(i)+(h/2)*k2x2);
   
   k4x1=f1(t(i)+h,x1(i)+ h*k3x1,x2(i)+h*k3x2);
   k4x2=f2(t(i)+h,x1(i)+ h*k3x1,x2(i)+h*k3x2);   
   
   x1(i+1)=x1(i)+(h/6)*(k1x1+2*k2x1+2*k3x1+k4x1);
   x2(i+1)=x2(i)+(h/6)*(k1x2+2*k2x2+2*k3x2+k4x2);   
end
%figure(2)
plot(t,x1)
%%
%%%%%%%%%%% FFT
step=0.001;
t0=0:step:tmax;   
L=size(x1,2);               % Length of signal
Fs = 1/step;              % Sampling frequency  , sample rime =1/Fs               
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(x1,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/(Fs)+1);
figure(2)
plot(t0,x1)
figure(3)
plot(f,abs(Y(1:NFFT/(Fs)+1)))

