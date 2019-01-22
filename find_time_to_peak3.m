function [p, slopes, highest_peaks] = find_time_to_peak3(R, RT_tp)
%Loop through different traces of same animal, same condition
p = [];
slopes = [];
%high_peak = [];

for i = 1:size(R,1)
    
    trace = R(i,:);
    trace_of_interest = R(i,200:300);

    [p, idx] = findpeaks(trace_of_interest, 'MinPeakProminence',0);
    highest_peaks(i) = max(p);


    
end