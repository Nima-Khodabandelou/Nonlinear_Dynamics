function sl_val = sl(mode, indx, atr_val, c)
if mode == -1; sl_val = c(indx, 2) + atr_val/2; end
if mode == +1; sl_val = c(indx, 3) - atr_val/2; end



