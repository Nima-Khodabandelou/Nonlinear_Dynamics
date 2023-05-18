function [onebranch,amp,threebranchesindex]=mms_forced_main_func_backbone(coeffs,LBsigma,UBsigma,step,f)
a1=coeffs(1,1);
a2=coeffs(1,2);
a3=coeffs(1,3);
a4=coeffs(1,4);
omega0=sqrt(a2);
delta=(9*a4*omega0^2-10*a3^2)/(24*omega0^3);
k=1;
for sigma=LBsigma:step:UBsigma  
    amp(k,1:3)=roots([1 -2*sigma/delta (a1^2+4*sigma^2)/(4*delta^2) -((f/(2*omega0))^2)/(delta^2)]);
    amp(k,4)=abs(sqrt(amp(k,1))-sqrt(amp(k,2)));
    amp(k,5)=sigma;
    k=k+1;
end
amp1=real(amp);
amp2=imag(amp);  
if a4<=0
    imagfind=find(amp2);
    remimagamp2=rem(imagfind,size(amp,1));
    zeroremimagamp2=find(~remimagamp2);
    remimagamp2(zeroremimagamp2)=size(amp,1);
    threebranchesindex=min(remimagamp2);  %  left three branches
    k=1;
    for i=threebranchesindex:size(amp,1)
        for j=1:3
            if imag(amp(i,j))==0
                onebranch(k,1)=amp(i,5);
                onebranch(k,2)=sqrt(amp(i,j));
            else
                continue
            end
        end
        k=k+1;
    end
else
    imagfind=find(amp2);
    remimagamp2=rem(imagfind,size(amp,1));
    threebranchesindex=remimagamp2(size(remimagamp2,1)); %  right three branches
    k=1;
    for i=1:threebranchesindex
        for j=1:3
            if imag(amp(i,j))==0
                onebranch(k,1)=amp(i,5);
                onebranch(k,2)=sqrt(amp(i,j));
            else
                continue
            end
        end
        k=k+1;
    end    
end
end