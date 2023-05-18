clc
clf
% verification with ode45 was not successful
clearvars  % OMEGA: excitation freq. in MMS -> OMEGA=omega0+eps*zigma
data=xlsread('data.xls');
a=0.02:0.01:3;
%a=0.1:0.1:30;
zig1=zeros(size(a,2),size(data,1));
zig2=zeros(size(a,2),size(data,1));
zigforexcel=zeros(size(a,2),2*size(data,1));
for sel=1:size(data,1)
coeffs=data(sel,:);
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = f*cos(OMEGA*t)
f=1;
a1=coeffs(1,1);
a2=coeffs(1,2);
a3=coeffs(1,3);
a4=coeffs(1,4);
omega0=sqrt(a2);
figure(1)
%  qddot = -a(1)*qdot - a(2)*q - a(3)*q^2 - a(4)*q^3  
%  x1=q   
%  x2=qdot


delta=(9*a4*omega0^2-10*a3^2)/(24*omega0^3);
zig1(:,sel)=delta*a.^2+sqrt(((f/(2*omega0))^2-((1/2).*a*a1).^2)./a.^2);
plot(zig1(:,sel),a);
hold on
zig2(:,sel)=delta*a.^2-sqrt(((f/(2*omega0))^2-((1/2).*a*a1).^2)./a.^2);
plot(zig2(:,sel),a);
hold on
zigforexcel(:,2*sel-1)=zig1(:,sel);
zigforexcel(:,2*sel)=zig2(:,sel);
end
zigforexcel=real(zigforexcel);
a=a';
atotal=[a;flipud(a)];
zigtotal=zeros(2*size(a,1),size(data,1)+1);
j=1;
for i=1:2:2*size(data,1)
zigtotal(:,j)=[zigforexcel(:,i);flipud(zigforexcel(:,i+1))];
j=j+1;
end
zigtotal(:,size(data,1)+1)=atotal;
%% sorting data for plot
clc
clearvars
data1=load('datasortforplot.txt');
a=0.02:0.01:3;
atotal=[a';flipud(a')];
zigtotal=[[data1(:,1);flipud(data1(:,2))]...
         [data1(:,3);flipud(data1(:,4))]...
                   atotal];

%%
% response amp vs excitation amp
clc
clf(figure(2))
clearvars
a1=0;a2=6;a3=0;a4=0.07;omega0=sqrt(a2);
%sigma=0.01;
f=1:-0.01:0;
aa=zeros(20,size(f,2));
k=1;
sigma=0.1;
starting_points=linspace(-10,10,1000);
%for sigma=-0.1:0.001:0.1  g=0.9
    for g=1:-0.01:0.1
        for i=1:100
        delta = (9*a4*omega0^2-10*a3^2)/(24*omega0^3);
        func = @(x) x.^6-2*sigma*x.^4/delta+(a1^2+4*sigma^2)*x.^2/(4*delta^2)-g^2/(4*delta^2*a2);
        x0 = starting_points(i); % starting point
        c1(i) = fzero(func,x0);
        end
        x_unique=c1(find(c1<0));
        x_unique2=unique(x_unique);        
        aa(1:size(x_unique2,2),k)=x_unique2';
        k=k+1;
    end
    plot(f,aa);
    hold on
    k=1;
%end

func = @(x) x.^3-6*x.^2+11*x-6;
        x0 = 2.5; % starting point
        c1 = fzero(func,x0);
        
x = linspace(0,1,100);
y = @(x) x.^3-6*x.^2+11*x-6;
zx = x(y(x).*circshift(y(x),[0 -1]) <= 0);  % Estimate zero crossings
zx = zx(1:end-1);                           % Eliminate any due to ‘wrap-around’ effect
for k1 = 1:length(zx)
    fz(k1) = fzero(y, zx(k1));
end

%%
clc
clearvars
data=xlsread('data.xls');
coeffs=data(1,:);
a1=coeffs(1,1);
a2=coeffs(1,2);
a3=coeffs(1,3);
a4=coeffs(1,4);
omega0=sqrt(a2);
sigma=0.1;
delta = (9*a4*omega0^2-10*a3^2)/(24*omega0^3);
lb = -10;             % Set a lower bound for the function.
ub = 10;          % Set an upper bound for the function.
%x = NaN*ones(1000,1);             % Initializes x.
starting_points=linspace(lb,ub,1000);f=1
for f=0.01:0.01:1
    for i=1:1000
        % Look for the zeros in the function's current window.
        x(i)=fzero(@(x)x.^6-2*sigma*x.^4/delta+(a1^2+4*sigma^2)*x.^2/(4*delta^2)-f^2/(4*delta^2*a2), starting_points(i));
    end
    x_unique=x(diff(x)>1e-4);
    x_unique1=x_unique(find(x_unique<0));
    x_unique2=unique(x_unique1);
end
%%



clf
sigma=0.1;
f=0.5;
delta = (9*a4*omega0^2-10*a3^2)/(24*omega0^3);
x=-3.8:0.01:3.8;
func = x.^6-2*sigma*x.^4/delta+(a1^2+4*sigma^2)*x.^2/(4*delta^2)-f^2/(4*delta^2*a2);
plot(x,func)


d=[-2 -2 -1 -1 0 1 1 1 2 2];
d1=d(find(d<0));
d2=unique(d1);
