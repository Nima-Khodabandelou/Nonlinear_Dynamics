clc
clf
clearvars
clf(figure(1))
cf=-[0 254 0 -3.6];
zigma=-1:0.1:5;
omega0=sqrt(-cf(2));
f=1;
OMEGA=omega0+zigma(5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zigma=[   1.2     1.119,0.13                     ]
% init =[  1.01,0   -0.13,0                      ]
OMEGA=omega0+1.119;
f1=@(t,x1,x2) x2;
f2=@(t,x1,x2) cf(2)*x1+cf(4)*x1^3+f*cos(OMEGA*t);
t(1)=1;x1(1)=0;x2(1)=0;
h=0.001;N=500000;
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
plot(t,x1);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxamp=zeros(size(zigma,2),1);
for j=1:size(zigma,2)
    OMEGA=omega0+zigma(j);
    f1=@(t,x1,x2) x2;
    f2=@(t,x1,x2) cf(2)*x1+cf(4)*x1^3+f*cos(OMEGA*t);
    t(1)=0;x1(1)=0;x2(1)=0;
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
    maxamp(j)=max(x1(80000:100001));
end
%%
clf(figure(2))
plot(zigma,maxamp')
hold on
a1=-cf(1);
a2=-cf(2);
a3=-cf(3);
a4=-cf(4);
%clf(figure(3))
a=0.01:0.01:3;
delta=(9*a4*omega0^2-10*a3^2)/(24*omega0^3);
zig1=delta*a.^2+sqrt(((f/(2*omega0))^2-((1/2).*a*a1).^2)./a.^2);
plot(zig1,a);
hold on
zig2=delta*a.^2-sqrt(((f/(2*omega0))^2-((1/2).*a*a1).^2)./a.^2);
plot(zig2,a);
hold on




