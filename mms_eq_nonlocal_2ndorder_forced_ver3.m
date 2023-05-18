clc
clf
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = f*cos(OMEGA*t)
% verification with ode45 was not successful
clearvars  % OMEGA: excitation freq. in MMS -> OMEGA=omega0+eps*zigma
data=xlsread('data.xls');
f=1;


coeffs=data(2,:);
a1=coeffs(1,1);
a2=coeffs(1,2);
a3=coeffs(1,3);
a4=coeffs(1,4);
% a1=0;
% a2=1e12;
% a3=0;
% a4=-0.7;
omega0=sqrt(a2);
delta=(9*a4*omega0^2-10*a3^2)/(24*omega0^3);
figure(1)
k=1;
LBsigma=-5e-6;
UBsigma=1e-6;
step=(UBsigma-LBsigma)/1000;
for sigma=LBsigma:step:UBsigma  
    amp(:,k)=roots([1 -2*sigma/delta (a1^2+4*sigma^2)/(4*delta^2) -((f/(2*omega0))^2)/(delta^2)]);
    k=k+1;
end
amp(4,:)=LBsigma:step:UBsigma;
amp=amp';

amp1=real(amp);
amp2=imag(amp);
imagfind=find(amp2);
remimagamp2=rem(imagfind,size(amp,1));
zeroremimagamp2=find(~remimagamp2);
remimagamp2(zeroremimagamp2)=size(amp,1);
threebranchesindex=min(remimagamp2)-1;  %  left three branches
k=1;
for i=threebranchesindex+1:size(amp,1)
 for j=1:3   
    if imag(amp(i,j))==0
       onebranch(k,1)=amp(i,4); 
       onebranch(k,2)=sqrt(amp(i,j));
    else
       continue
    end
 end
 k=k+1;
end
plot(amp(1:threebranchesindex,4),sqrt(amp(1:threebranchesindex,1:3)));
hold on
plot(onebranch(:,1),onebranch(:,2));
left=zeros(threebranchesindex,4);
left(:,2:4)=sqrt(amp(1:threebranchesindex,1:3));
left(:,1)=amp(1:threebranchesindex,4);