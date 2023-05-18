function xdot=First_order_ODEs(t,x)
omega0=sqrt(12);
sigma=0.12*omega0;
a1=-0.05;
f=1;
a2=f/(2*omega0);
a3=sigma;
a4=-3*2/(8*omega0);
a5=a2;
xdot=zeros(2,1);
xdot(1)=a1*x(1)+a2*sin(x(2));
xdot(2)=a3+a4*x(1)^3+a5*cos(x(2))/x(1);

% a1=-0.1;
% a2=-12;
% xdot(1)=x(2);
% xdot(2)=a1*x(2)+a2*x(1)^3;
end

