function [p, slopes, highest_peaks] = find_time_to_peak(R, RT_tp)
%Loop through different traces of same animal, same condition
p = [];
slopes = [];
%high_peak = [];

for i = 1:size(R,1)
    if RT_tp(i) >0
    trace = R(i,:);
    trace_of_interest = R(i,200:300);
    figure; hold on; plot(trace)
    ylim([0 100])
    [p, idx] = findpeaks(trace_of_interest, 'MinPeakProminence',0);
    highest_peaks(i) = max(p);
    delay = 200;
    if isempty(idx)
        Warning('no peak')
    else
        %Loop through different peaks and plot them (to do quality check)
        
        for j =1:length(idx)
            hold on; plot(idx(j)+delay, trace(idx(j)+delay), 'k*')
            %trace lines passing from RT point to peak(s)
            hold on; plot([RT_tp(i) idx(j)+delay], [trace(RT_tp(i)) trace(idx(j)+delay)], '-.r', 'LineWidth',3)
            %compute slope between points
            slopes(i,j) = (trace(idx(j)+delay) - trace(RT_tp(i)))./(idx(j)+delay - RT_tp(i));
            
        end
    end
    end
end

%highest_peaks = max(p, [], 2);