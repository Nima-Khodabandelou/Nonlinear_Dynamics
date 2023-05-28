clc

clear all

clf
%%%%%%%%%%%%%%%%%%%%%%%%%%%% data preparation
c = load('ada5.txt');

% asset: ada-usdt -> base=ada, quote=usdt
dr = 200; % dr: data range

c = c(1:dr,:); % c: candle

cc = c(1:dr,4); % cc: candle close


co = c(1:dr,1); % cc: candle close



ch = c(1:dr,2); % cc: candle close


cl = c(1:dr,3); % cc: candle close

nd = size(cc); % nd: No. of data

nd = nd(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% intial data
cap = 1000; % $


lev = 2; % leverage: for Long -> no lev and for short -> lev = 2

mp = 8; % mp: moving average period
atr_p = 5; % ATR period


indx = mp + 1; % indx: index of the first cand to start trd


bb = cap; % bb: buy balance in base asset
margin = 0.3; % 30% margin is considered


sb = (1-margin)*lev*(cap/cc(indx)); % sb: sell balance in quote asset

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% m: moving average
m = zeros(nd, size(mp,2));
for i=mp+1:nd;
    lb = i-mp; % lb: lower_bound
    ub = i-1; % ub: upper_bound
    ma = sum(cc(lb:ub,1))/mp;   
    m(i) = ma;    
end
%%% setting initial moving average data (data prior to mp) to constant

nonzero_m = m(m(:)~=0);
m(m(:)==0) = nonzero_m(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%max_point = max(max(c(:,1:4)));

%min_point = min(min(c(:,1:4)));



% vert_line_x = [mp, mp];

% vert_line_y = [min_point, max_point];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% initial calculation

% mode = -1 for short and mode = 1 for long
state = zeros(2,4);
if cc(indx) >= m(indx)
    mode = 1;
    bb = bb/cc(indx); % result is in qoute asset
    % buy/sell at cc. Modify later for inner-cand price
    state (1,:) = [mode, indx, cc(indx), bb];
else
    mode = -1;
    sb = sb*cc(indx); % result is in base asset
    state (1,:) = [mode, indx, cc(indx), sb];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% cand plot


plot_data = c(1:dr, 1:4);
%       HighPrices,      LowPrices,     ClosePrices,    OpenPrices
candle(plot_data(:,2), plot_data(:,3), plot_data(:,4), plot_data(:,1));
hold on
plot(m(1:mp+2), 'color', 'black', 'linewidth', 2);
hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%% sl plot

k=1;
while indx <= nd
    indx = state(k, 2);
    atr_data = c(indx-atr_p+1:indx, :);
    atr_val = atr(atr_data, atr_p);
    sl = sl(state(k, 1), indx, atr_val, c);
    scatter(indx, sl, 230, '+', 'LineWidth',3) 
    indx = indx + 1;
    if ch(indx) >= sl %short should be closed and debt should be paid
        mode = 1;
        bb = bb/cc(indx); % result in qoute asset
        % buy/sell at cc. Modify later for inner-cand price
        state (1,:) = [mode, indx, cc(indx), bb];
    else
        mode = -1;
        sb = sb*cc(indx); % result in base asset
        state (1,:) = [mode, indx, cc(indx), sb];
    end
end    


    
    
    
    




