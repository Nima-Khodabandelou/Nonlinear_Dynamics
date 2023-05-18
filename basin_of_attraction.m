clc
clf
clearvars
a1=0.01;
a2=11;
a3=0;
a4=-3;
omega0=sqrt(a2);
T=2*pi/omega0;
f=1;
sigma=1;
% The basin of attraction of an oscillator can be calculated by integrating its equation
% of motion in time for various grid points of initial velocity and displacement. If a
% point of an initial displacement and velocity leads to a stable solution, it is represented
% with a specific color in the phase plane. The collection of these points forms an area
% of the safe basin. If however the point of initial conditions leads to unstable response,
% it is represented using a different color on the phase space. The collection of these
% forms the unsafe zone. Therefore, the phase space is divided into safe and unsafe
% zones.
c1=1
OMEGA=c1*omega0;
ode=@(t,x)[x(2);...
    -a1*x(2)-a2*x(1)-a3*x(1)^2-a4*x(1)^3+f*cos(OMEGA*t)];
% xdot=zeros(2,1);
% xdot(1)=a1*x(1)+a2*sin(x(2));
% xdot(2)=a3+a4*x(1)^3+a5*cos(x(2))/x(1);
[t,x]=ode45(ode, [0 100],[-1 1]);
figure(1)
plot(x(:,1),x(:,2));




