clc
clf
clearvars
omega0=sqrt(12);
sigma=0.12*omega0;
a1=-0.34;
f=1;
a2=f/(2*omega0);
a3=sigma;
a4=-3*2/(8*omega0);
a5=a2;
for i=-0.3:0.03:0.1
    a3=i*omega0;
    ode=@(t,x)[a1*x(1)+a2*sin(x(2));
        a3+a4*x(1)^3+a5*cos(x(2))/x(1)];
    % xdot=zeros(2,1);
    % xdot(1)=a1*x(1)+a2*sin(x(2));
    % xdot(2)=a3+a4*x(1)^3+a5*cos(x(2))/x(1);
    [t,x]=ode45(ode, [0 100],[0.8 0]);
    figure(1)
    plot(x(:,1),x(:,2));
    hold on
end

i=0.1:0.01:0.15;

