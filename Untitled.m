clc
clearvars
a1=0;
a2=10;
a3=0;
a4=-0.01;
omega0=sqrt(a2);
sigma=0.1;
delta = (9*a4*omega0^2-10*a3^2)/(24*omega0^3);

lb = -10;             % Set a lower bound for the function.
ub = 10;          % Set an upper bound for the function.
%x = NaN*ones(1000,1);             % Initializes x.
starting_points=linspace(lb,ub,1000);%f=0.2
k=1;
f=0.1;
for i=1:1000
    x(i)=fzero(@(x)x.^3-2*sigma*x.^2/delta+(a1^2+4*sigma^2)*x/(4*delta^2)-f^2/(4*delta^2*a2), starting_points(i));
end
x_unique=unique(x)';
zer(k)=x_unique(1);
k=k+1;
for i=2:size(x_unique,2)
    if (abs(x_unique(i))-abs(x_unique(i-1)))<1e-3
        continue
    else
        zer(k)=x_unique(i);
        k=k+1;
    end
end
f=-10:0.1:10;
plot(f,zer);

    