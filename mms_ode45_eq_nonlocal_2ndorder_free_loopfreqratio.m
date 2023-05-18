clc
%close all
clf(figure(1))
% verified
clearvars
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = 0
data=xlsread('data.xls');
freq_ratio=zeros(3,1);
%q=zeros(100,1);

for sel=1:size(data,1)    
    k=1;
    for qmax=0:0.1:1
        coeffs=data(sel,:);
        % qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = 0
        a1=coeffs(1,1);        
        a2=coeffs(1,2);
        a3=coeffs(1,3);
        a4=coeffs(1,4);        
        omega0=sqrt(a2);
        eps=1;
        tmax=20;
        time=0:0.001:tmax;
        func = @(x) ((3*a4*a2+2*a3^2)/(a2^2))*x^3+(-24*a3/a2)*x^2+96*x-96*qmax;
        x0 = 0; % starting point
        c1 = fzero(func,x0);
        test=func(c1)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% time history
%         figure(2)
%         a=c1*exp(-a1*time/2);
%         beta=c1^2*time*(9*a4*omega0^2-10*a3^3)/(24*omega0^3);
%         A=(a/2).*exp(i*beta);
%         Abar=(a/2).*exp(-i*beta);
%         q(:,sel)=-(2*a3*A.*Abar)/a2+...
%             A.*exp(i*omega0*time)+...
%             (a3*A.^2)/(3*a2).*exp(i*2*omega0*time)+...
%             (3*a4*A.^3*a2+2*a3^2*A.^3)/(24*a2^2).*exp(i*3*omega0*time)+...
%             Abar.*exp(-i*omega0*time)+...
%             (a3*Abar.^2)/(3*a2).*exp(-i*2*omega0*time)+...
%             (3*a4*Abar.^3*a2+2*a3^2*Abar.^3)/(24*a2^2).*exp(-i*3*omega0*time);
%         plot(time,q(:,sel));
%         hold on
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% freq ratio
        freq_ratio(k,sel)=1+(9*a4*a2-10*a3^2)*(c1^2)/(24*a2^2);
        k=k+1;
    end
     qmax=0:0.1:1;
     figure(1)
     plot(qmax,freq_ratio(:,sel));
     hold on
end
%%
clc
clearvars
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = 0
tmax=5000;
step=1;
time=0:step:tmax;
q=zeros(size(time,2),1);
data=xlsread('data.xls');
clf(figure(2))
for sel=1:size(data,1)
    qmax=1;
    coeffs=data(sel,:);
    % qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = 0
    a1=coeffs(1,1);
    a2=coeffs(1,2);
    a3=coeffs(1,3);
    a4=coeffs(1,4);
    omega0=sqrt(a2);
    eps=1;    
    func = @(x) ((3*a4*a2+2*a3^2)/(a2^2))*x^3+(-24*a3/a2)*x^2+96*x-96*qmax;
    x0 = 0; % starting point
    c1 = fzero(func,x0);
    test=func(c1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% time history    
    a=c1*exp(-a1*time/2);
    beta=c1^2*time*(9*a4*omega0^2-10*a3^3)/(24*omega0^3);
    A=(a/2).*exp(i*beta);
    Abar=(a/2).*exp(-i*beta);
    q(:,sel)=-(2*a3*A.*Abar)/a2+...
        A.*exp(i*omega0*time)+...
        (a3*A.^2)/(3*a2).*exp(i*2*omega0*time)+...
        (3*a4*A.^3*a2+2*a3^2*A.^3)/(24*a2^2).*exp(i*3*omega0*time)+...
        Abar.*exp(-i*omega0*time)+...
        (a3*Abar.^2)/(3*a2).*exp(-i*2*omega0*time)+...
        (3*a4*Abar.^3*a2+2*a3^2*Abar.^3)/(24*a2^2).*exp(-i*3*omega0*time);
    figure(2)
    plot(time,q(:,sel));
    hold on
end
q=real(q);
time=time';
%%
%verification
%  qddot = -a(1)*qdot - a(2)*q - a(3)*q^2 - a(4)*q^3  
%  x1=q   
%  x2=qdot
clc
clearvars


qmax=1;
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = 0
tmax=0.00006;
step=0.00000001;
time=0:step:tmax;
data=xlsread('data.xls');
clf(figure(3))
coeffs=data(1,:);
cf = -[coeffs(1) coeffs(2) coeffs(3) coeffs(4)];
ode=@(t,w_h)[w_h(2);cf(1)*w_h(2)+cf(2)*w_h(1)+cf(3)*w_h(1)^2+cf(4)*w_h(1)^3];
[t,w_h]=ode45(ode, [0 tmax],[qmax 0]);
a1=coeffs(1,1);
a2=coeffs(1,2);
a3=coeffs(1,3);
a4=coeffs(1,4);
omega0=sqrt(a2);
eps=1;
func = @(x) ((3*a4*a2+2*a3^2)/(a2^2))*x^3+(-24*a3/a2)*x^2+96*x-96*qmax;
x0 = 0; % starting point
c1 = fzero(func,x0);
test=func(c1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% time history
a=c1*exp(-a1*time/2);
beta=c1^2*time*(9*a4*omega0^2-10*a3^3)/(24*omega0^3);
A=(a/2).*exp(i*beta);
Abar=(a/2).*exp(-i*beta);
q=-(2*a3*A.*Abar)/a2+...
    A.*exp(i*omega0*time)+...
    (a3*A.^2)/(3*a2).*exp(i*2*omega0*time)+...
    (3*a4*A.^3*a2+2*a3^2*A.^3)/(24*a2^2).*exp(i*3*omega0*time)+...
    Abar.*exp(-i*omega0*time)+...
    (a3*Abar.^2)/(3*a2).*exp(-i*2*omega0*time)+...
    (3*a4*Abar.^3*a2+2*a3^2*Abar.^3)/(24*a2^2).*exp(-i*3*omega0*time);
%plot(t,w_h(:,1));
 plot(t,w_h(:,1),'g',time,q,'b--o');