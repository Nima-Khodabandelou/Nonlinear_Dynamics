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
omega0=sqrt(c(2));
w_ext = 0*omega0:1:2*omega0; 
% RK4 sol
clf(figure(1))
h=0.01;N=500;
for i=1:size(w_ext,2)
    f1=@(t1,x1,x2) x2;
    f2=@(t1,x1,x2) -c(1)*x2- c(2)*x1 - c(3)*x1^2- c(4)*x1^3 - c(5)*x1*x2 - c(6)*x2*x1^2 -c(7)+Ext_amp*cos(w_ext(i)*t1);
    t2=0;x11=0;x21=0;    
    [t1,x1,x2]=RK4(N,h,t2,x11,x21,f1,f2);
    y1(:,1)=x1;
    y1(:,2)=x2;  
    z1(:,i)=x1;
    plot3(t1',i*ones(size(t1)),y1(:,1));
    colorbar
    hold on
end

clearvars
clf
N = 1024;
n = 0:N-1;
w0 = 2*pi/5;
x = sin(w0*n)+10*sin(2*w0*n);
s = spectrogram(x);
spectrogram(x,'yaxis')

clear z
clf
z(:,1) = t1(1:50)';
z(:,2) = y1(1:50,1);
z(z(:,2)<0,:)=[];
for i=1:size(z,1)
class(i) = ;
end
pntColor = hsv(length(Class));
figure(2),hold on
for ind = 1:length(uClass)
    scatter(z1(class == uClass(ind)), z2(class == uClass(ind)), 150, 'MarkerFaceColor',pntColor(ind,:),'Marker','.')
end

