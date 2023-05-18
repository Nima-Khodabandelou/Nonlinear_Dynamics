clc
clf
clearvars
data=xlsread('data.xls');
coeffs=data(4,:);
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3+ a(5)qdot*q + a(6)*qdot*q^2 +a(7) = f*cos(OMEGA*t)
f=0;
a1=coeffs(1,1);
a2=coeffs(1,2);
a3=coeffs(1,3);
a4=coeffs(1,4);
a5=coeffs(1,5);
a6=coeffs(1,6);
a7=coeffs(1,7);
omega0=sqrt(a2);
qmax=1;
tmax=0.005;
%  qddot = -a(1)*qdot - a(2)*q - a(3)*q^2 - a(4)*q^3 -a(5)  
%  x1=q   
%  x2=qdot
zigma=0;
omega=omega0+zigma;
cf = -[a1 a2 a3 a4 a5 a6 a7];
ode=@(t,w_h)[w_h(2);
                   cf(1)*w_h(2)+cf(2)*w_h(1)+...
                   cf(3)*w_h(1)^2+cf(4)*w_h(1)^3+...
                   cf(5)*w_h(2)*w_h(1)+cf(6)*w_h(2)*w_h(1)^2+cf(7)+f*cos(omega*t)];
[t,w_h]=ode45(ode, [0 tmax],[qmax 0]);
figure(1)
plot(t,w_h(:,1));
%figure(2)
%plot(w_h(:,1),w_h(:,2));
%%
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3+ a(5)qdot*q + a(6)*qdot*q^2 +a(7) = f*cos(OMEGA*t)
f=1e7;
tic
clf(figure(3))
zigma=omega0;
omega=omega0+zigma;
nS = 1;
T_ext = 2*pi/omega; 
tMin = 0;
tMax = T_ext; 
% Initial Conditions   
xinit=0;
xdotinit=0;
% OUPUT  ==============================================================  
      
figure(3)   % Poincare Section
%pos = [0.02 0.05 0.42 0.42];
hold on
nonlinode=@(t,y)[w_h(2);
                   cf(1)*y(2)+cf(2)*y(1)+...
                   cf(3)*y(1)^2+cf(4)*y(1)^3+...
                   cf(5)*y(2)*y(1)+cf(6)*y(2)*y(1)^2+cf(7)+f*cos(omega*t)];
opts = odeset('AbsTol',1e-2);
for cP = 1:800 
      [t,y]=ode45(nonlinode,[tMin tMax],[xinit xdotinit],opts);
      xP = y(size(y,1),1);  yP = y(size(y,1),2);
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



