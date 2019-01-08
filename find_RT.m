function [RT_tp, RT_ms] = find_RT(data_matrix_thresh)
% Identify RT for each trace.

% First we identify the highest value in the trace before stimulus onset
highest_noise = max(data_matrix_thresh(:, 100:150),[],2);
% Set hard threshold to 1 if the highest noise is less than 1
if any(highest_noise<1)
    highest_noise(highest_noise<1) = 1;
end

RT_tp = [];
RT_ms = [];



for i = 1:size(data_matrix_thresh,1)
    one_row = data_matrix_thresh(i,152:end);
    %RT_tp(i) = find( cumsum(one_row>highest_noise(i), 'omitnan') ==1);
    second_der = [0, diff(diff(one_row)),0];
    [pks, idx]=findpeaks(second_der);
    idx = idx(pks>0.04);%find(pks>0.05);
    if isempty(idx)
        warning(['you have to hand pick RT for trial number "i"']);
    else 
        RT_tp(i) = 150+min(idx);
        %RT in ms with Stim Onset = 0 sec
        RT_ms(i) = round(RT_tp(i)/0.3 ,0)-500; 
    end
    %0.3 because I have 300 time points for every 1000 ms. Hence RT is
    %converted from tp units to ms units
end