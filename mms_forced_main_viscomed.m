clc
clf
% second order MMS
% qddot + a(1)*qdot + a(2)*q + a(3)*q^2+ a(4)*q^3  = f*cos(OMEGA*t)
clearvars  % OMEGA: excitation freq. in MMS -> OMEGA=omega0+eps*zigma
data=xlsread('data.xls');
f=1;
LBsigma=-10e-6;
UBsigma=10e-6;
step=(UBsigma-LBsigma)/1000;
ampsize=(UBsigma -LBsigma)/step+1;
%backbone1=zeros(round(ampsize),5,3);
for sel=1:size(data,1)
    coeffs=data(sel,:);
    a1=coeffs(1,1);
    a2=coeffs(1,2);
    a3=coeffs(1,3);
    a4=coeffs(1,4);
    omega0=sqrt(a2);
    delta=(9*a4*omega0^2-10*a3^2)/(24*omega0^3);
    k=1;    
    [onebranch,amp,threebranchesindex]=mms_forced_main_func_backbone(coeffs,LBsigma,UBsigma,step,f);
    clf(figure(1))
    % plot(amp(1:threebranchesindex,5),sqrt(amp(1:threebranchesindex,1:3)));
    % hold on
    % plot(onebranch(:,1),onebranch(:,2));
    amp=real(amp);
    backbone1(:,:,sel)=amp(:,1:5);
    switch sel
        case 1
        backbone21=onebranch(:,1:2);
        case 2
        backbone22=onebranch(:,1:2);    
        case 3
        backbone23=onebranch(:,1:2);
    end
end
% onebranch(size(amp,1)-max(threebranchesindex_save):size(onebranch,1),1:2)
%%
clf(figure(2))
for sel=1:size(data,1)
    if threebranchesindex_save(sel)>10
        leftdim=threebranchesindex_save(sel);
        left=zeros(leftdim,5);
        left(:,2:4)=sqrt(backbone1(1:leftdim,1:3,sel));
        left(:,1)=backbone1(1:leftdim,5,sel);
        left(:,5)=backbone1(1:leftdim,4,sel); % difference
        dm=left(:,5)<max(cutindex);
        dm2=find(~dm);
        cut=dm2(1);
        left(1:cut,:)=[];
    else
        left=backbone1(:,:,sel);        
    end
    plot(real(left(:,5)),left(:,2:4))
    hold on
    switch sel
        case 1
            plot(backbone21(:,1),backbone21(:,2))
        case 2
            plot(backbone22(:,1),backbone22(:,2))
        case 3
            plot(backbone23(:,1),backbone23(:,2))
    end
    hold on
end

