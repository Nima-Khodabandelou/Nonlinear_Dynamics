function [t,x1,x2]=RK4(N,h,t,x11,x21,f1,f2)
t(1)=t;x1(1)=x11;x2(1)=x21;
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
end