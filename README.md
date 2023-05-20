# Strat_studies
clc
clear all

clf
data = readtable('ADA5m.csv');
data = data{:,:};
data_range = 8000;

data = data(1:data_range,:);
cc = data(1:data_range,5);
dim = size(cc);
dim = dim(1);

t = data(:,1);

ma_p = [5, 30, 30, 30];

ma_vec = zeros(dim, size(ma_p,2));

for j=1:size(ma_p,2);
    for i=ma_p(j)+1:dim;
        lower_bound = i-ma_p(j);
        upper_bound = i-1;
        ma = sum(cc(lower_bound:upper_bound,1))/ma_p(j);   
        switch j
            case 1
                ma1(i) = ma;
            case 2
                ma2(i) = ma;
            case 3
                ma3(i) = ma;
            case 4
                ma4(i) = ma;
        end        
    end
end

nonzero_ma1 = ma1(ma1(:)~=0);
ma1(ma1(:)==0) = nonzero_ma1(1);

nonzero_ma2 = ma2(ma2(:)~=0);
ma2(ma2(:)==0) = nonzero_ma2(1);

nonzero_ma3 = ma3(ma3(:)~=0);
ma3(ma3(:)==0) = nonzero_ma3(1);

nonzero_ma4 = ma4(ma4(:)~=0);
ma4(ma4(:)==0) = nonzero_ma4(1);

max_point = max(max(data(:,2:5)));
min_point = min(min(data(:,2:5)));

vert_line_x = [ma_p(4), ma_p(4)];
vert_line_y = [min_point, max_point];
%%
% HighPrices, LowPrices, ClosePrices, OpenPrices

plot_data = data(1:data_range, 2:5);
candle(plot_data(:,2), plot_data(:,3), plot_data(:,4), plot_data(:,1));

hold on
plot(ma1(1:data_range), 'color', 'red', 'linewidth', 2);

hold on
plot(ma2(1:data_range), 'color', 'black', 'linewidth', 2);

hold on
plot(ma3(1:data_range), 'color', 'black', 'linewidth', 2);

hold on
plot(ma4(1:data_range), 'color', 'black', 'linewidth', 2);

hold on
plot(vert_line_x, vert_line_y, 'color', 'black', 'linewidth', 3)
% d: delta; two sides : buy and sell
% d_p_ma: difference between cc price and ma price at given time
cap = 1000; % $
lev = 2; % leverage
balance = cap*lev;
cap_per_side = 0.7*balance/2; 
% setup:
% 1-if first cc is near ma (abs(d_p_ma) <= ATR5):
%   11-the next cc is not engulfed by the first candle:
%       111-the next cc crosses ma:
%           1111-if the next cc crosses ma upward -> buy
%           1112-if the next cc crosses ma downward -> sell
%   12-the next cc and possibly each of its successors are engulfed by the first candle:
%       wait till engulfing ends. Then goto 11
% 2-if first cc is not near ma (abs(d_p_ma) > ATR5):
%
%
%
%


