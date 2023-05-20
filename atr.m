function atr_val = atr(c, p)
% c components: open, high, low, close
% c is a matrix;
% p is ATR period;
% ATR(1)=cc(2)-cc(3)
nd = size(c, 1); % nd is No. of rows
k=1;
if nd >= p
    for i=nd:-1:p
        j=i-1;
        if i==1; j=1; end           
        tr(k) = max([c(i,2)-c(i,3), c(i,2)-c(j,4), c(i,3)-c(j,4)]);
        k=k+1;
    end
end 
atr_val = tr/p;