clear 
clc
tic 
global c
c(1) =  0 ;
c(2) =  29;
c(3) =  0;   
c(4) =  -10.98;
c(5) =  0;
c(6) =  0;
c(7) =  0;

Ext_amp = 1;
% Time domain
%    nT number of points before plotting
%    nP number of period iteriations 
%    nS start plotting number
%    w_ext, T_ext drivingg force angular velocity & period
%    h time step
nS = 1;
omega0=sqrt(c(2));
w_ext = omega0; 
T_ext = 1*pi/w_ext; 
tMin = 0;
tMax = T_ext; 
eps=3;
sigma=eps*w_ext;
% Initial Conditions   
xinit=0;
xdotinit=0;
% ode
% OUPUT  ==============================================================  

%% RK4 sol
%clear y
clf(figure(1))
clf(figure(2))
figure(1)   % Time Response
f1=@(t1,x1,x2) x2;
f2=@(t1,x1,x2) -c(1)*x2- c(2)*x1 - c(3)*x1^2- c(4)*x1^3 - c(5)*x1*x2 - c(6)*x2*x1^2 -c(7)+Ext_amp*cos((w_ext+sigma)*t1);
t2=0;x11=0;x21=0;
h=0.01;N=100000;
[t1,x1,x2]=RK4(N,h,t2,x11,x21,f1,f2);
y1(:,1)=x1;
y1(:,2)=x2;
plot(t1,y1(:,1));
figure(2)
plot(y1(:,1),y1(:,2));
%% FFT on RK4
clf(figure(3))
clf(figure(4))
step=0.01;
L=size(x1,2);               % Length of signal
Fs = 1/step;              % Sampling frequency  , sample rime =1/Fs               
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(x1,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/(2)+1);
figure(3)
plot(t1,x1)
figure(4)
plot(f,abs(Y(1:NFFT/(2)+1)))
%axis([0 1 0 0.4])
%% ODE45 sol
%clear t y2
% nonlinode=@(t,y2)[y2(2); -c(1)*y2(2)-c(2)*y2(1)-c(3)*y2(1)^2-c(4)*y2(1)^3-c(5)*y2(1)*y2(2)-c(6)*y2(2)*y2(1)^2-c(7)+Ext_amp*cos((w_ext+sigma)*t)];
% clf(figure(5))
% clf(figure(6))
% opts = odeset('AbsTol',1e-8);
% [t,y2]=ode45(nonlinode,[tMin 100*tMax],[xinit xdotinit],opts);
% figure(5)
% plot(t,y2(:,1));
% figure(6)
% plot(y2(:,1),y2(:,2));
%%     +f*cos((w_ext+sigma)*t)
%clear y t        
nonlinode=@(t3,y3)[y3(2); -c(1)*y3(2)-c(2)*y3(1)-c(3)*y3(1)^2-c(4)*y3(1)^3-c(5)*y3(1)*y3(2)-c(6)*y3(2)*y3(1)^2-c(7)+Ext_amp*cos((w_ext+sigma)*t3)];
clf(figure(7))   % Poincare Section
%pos = [0.02 0.05 0.42 0.42];
hold on
opts = odeset('AbsTol',1e-9);
for cP = 1:250 
      [t3,y3]=ode45(nonlinode,[tMin tMax],[xinit xdotinit],opts);
      xP = y3(size(y3,1),1);  yP = y3(size(y3,1),2);
      if cP > nS
        plot(xP,yP,'b.')
        %xlim([-2 2])
        %ylim([-1.5 1.5])
      end
      tMin=tMax;
      tMax = tMin + cP*T_ext;
      xinit = xP;
      xdotinit = yP;
end
toc
%% route to chaos

rtochaos=zeros(2,2,2);
k=1;
for Ext_amp=0.1:0.1:20
    nonlinode=@(t4,y4)[y4(2); -c(1)*y4(2)-c(2)*y4(1)-c(3)*y4(1)^2-c(4)*y4(1)^3-c(5)*y4(1)*y4(2)-c(6)*y4(2)*y4(1)^2-c(7)+Ext_amp*cos((w_ext+sigma)*t4)];
    opts = odeset('AbsTol',1e-9);
    j=1;
    for cP = 1:250  % poincare section
        [t4,y4]=ode45(nonlinode,[tMin tMax],[xinit xdotinit],opts);
        xP = y4(size(y4,1),1);  yP = y4(size(y4,1),2);
        rtochaos(cP,1,k)=xP;
        rtochaos(cP,2,k)=yP;
        tMin=tMax;
        tMax = tMin + cP*T_ext;
        xinit = xP;
        xdotinit = yP;
    end
    k=k+1
end
rtochaos_disp=squeeze(rtochaos(:,1,:));
Ext_amp=0.1:0.1:20;
hor=Ext_amp.*ones(cP,size(Ext_amp,2));
clf(figure(8))
for i=1:200    
    scatter(hor(:,i),rtochaos_disp(:,i),'.','black')
    xlim([0 0.8])
    hold on
end





