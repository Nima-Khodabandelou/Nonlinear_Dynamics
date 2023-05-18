clc
clf(figure(1))
clf(figure(2))
clf(figure(3))
clearvars
% shooting technique for sdof vibratory xddt +a1*xdt+a2*x+a3*x^2+a4*x^3=Fext
% Fext=A*cos(OMEGA*time) 
% period T=2*pi/omega0        , omega0: natural linear freq.
% X1=x, X2=xdot  
% X1dot=X2,  
% X2dot=-a1*X2-a2*X1-a3*X1^2-a4*X1^3+f*cos(OMEGA*time)
% Initial cond: (eta1,eta2).We are seeking for appropriate (eta1,eta2)
% that yeilds priodic solution.
% X3=d_X1/d_eta1, X4=d_X1/d_eta2, X5=d_X2/d_eta1, X6=d_X2/d_eta2 therfore
% X3dot=X5, X4dot=X6, X5dot=-a1*X5-a2*X3-a3*2*X1*X3-a4*3*X1^2*X3
% X6dot=-a1*X6-a2*X4-a3*2*X1*X4-a4*3*X1^2*X4
% newton-raphson
%  [ [X3(T)    X4(T)]   [   ] ] [ deltaeta1 ]   [ eta10 - X1(T,eta10,eta20) ]
%  | |              | - | I | | |           | = |                           | 
%  [ [X5(T)    X6(T)]   [   ] ] [ deltaeta2 ]   [ eta20 - X2(T,eta10,eta20) ]
%  etanew = deltaeta+etaold
a1=0;
a2=10.5;
a3=0;
a4=-0.03;
omega0=sqrt(a2);
T=2*pi/omega0;
w_ext = omega0; 
f=1;
init=zeros(2,2);
k=1;

for sigma=0.2:-0.01:-0.4
     eta10=10.8;
     eta20=0;
     OMEGA=w_ext+sigma;
    for i=1:10        
        ode=@(t,X)[X(2);...
            -a1*X(2)-a2*X(1)-a3*X(1)^2-a4*X(1)^3+f*cos(OMEGA*t);...
            X(5);...
            X(6);...
            -a1*X(5)-a2*X(3)-a3*2*X(1)*X(3)-a4*3*(X(1)^2)*X(3);...
            -a1*X(6)-a2*X(4)-a3*2*X(1)*X(4)-a4*3*(X(1)^2)*X(4)];        
        [t,X]=ode15s(ode, [0 T],[eta10 eta20 1 0 0 1]);
        clf(figure(1))
        %figure(1)
        plot(t,X(:,1));
        %hold on        
        deltaeta=([X(size(X,1),3) X(size(X,1),4);...
            X(size(X,1),5) X(size(X,1),6)]-[1 0;0 1])\...
            [eta10-X(size(X,1),1);eta20-X(size(X,1),2)];
        eta10=eta10+deltaeta(1);
        eta20=eta20+deltaeta(2);
        if abs(deltaeta(:))<1e-2
            break
        end
    end
    init(:,k)=[eta10;eta20];
    k=k+1;
end
init(3,:)=0.2:-0.01:-0.4;
for i=1:size(init,2)
    ode=@(t,X)[X(2);...
        -a1*X(2)-a2*X(1)-a3*X(1)^2-a4*X(1)^3+f*cos((omega0+init(3,i))*t);...
        X(5);...
        X(6);...
        -a1*X(5)-a2*X(3)-a3*2*X(1)*X(3)-a4*3*X(1)^2*X(3);...
        -a1*X(6)-a2*X(4)-a3*2*X(1)*X(4)-a4*3*X(1)^2*X(4)];    
        [t,X]=ode23t(ode, [0 150*T],[init(1,i) init(2,i) 1 0 0 1]);
        clf(figure(2))
        plot(t,X(:,1));
        %hold on 
        resp_amp(i)=max(X(size(X,1)/2:size(X,1),1));
end
figure(3)
plot(init(3,:),resp_amp)

%%
% clf
%     ode=@(t,X)[X(2);...
%         -a1*X(2)-a2*X(1)-a3*X(1)^2-a4*X(1)^3+f*cos((omega0)*t);...
%         X(5);...
%         X(6);...
%         -a1*X(5)-a2*X(3)-a3*2*X(1)*X(3)-a4*3*X(1)^2*X(3);...
%         -a1*X(6)-a2*X(4)-a3*2*X(1)*X(4)-a4*3*X(1)^2*X(4)];    
%     [t,X]=ode113(ode, [0 20*T],[1 -1 1 0 0 1]);
% plot(t,X(:,1))
