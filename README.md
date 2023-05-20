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

mp = 5;
% m: moving average
m = zeros(dim, size(mp,2));

for i=mp+1:dim;
    lower_bound = i-mp;
    upper_bound = i-1;
    ma = sum(cc(lower_bound:upper_bound,1))/mp;   
    m(i) = ma;    
end

nonzero_m = m(m(:)~=0);
m(m(:)==0) = nonzero_m(1);

max_point = max(max(data(:,2:5)));
min_point = min(min(data(:,2:5)));

vert_line_x = [mp, mp];
vert_line_y = [min_point, max_point];
%
% HighPrices, LowPrices, ClosePrices, OpenPrices

plot_data = data(1:data_range, 2:5);
candle(plot_data(:,2), plot_data(:,3), plot_data(:,4), plot_data(:,1));

hold on
plot(m(1:data_range), 'color', 'black', 'linewidth', 2);

hold on
plot(vert_line_x, vert_line_y, 'color', 'black', 'linewidth', 2)

cap = 1000; % $
lev = 2; % leverage
bal = cap*lev; % bal: balance
cps = 0.7*bal/2; % cps: cap per side in base asset (here $)

mode = -1; % mode = -1 for short and mode = 1 for long
start = mp;
buy = [];
sell = [];

buy_bal = cps;
sell_bal = cps/cc(start+1); % sell_bal: sell balance

if cc(start+1) >= m(start+1)
    mode = 1;
    buy(1) = buy_bal/cc(start+1);
else
    mode = -1;
    sell(1) = sell_bal*cc(start+1);
end




    
    
    
    




