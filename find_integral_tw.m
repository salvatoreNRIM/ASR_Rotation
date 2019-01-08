function ampl_resp = find_integral_tw(time_series, RT_tp, tw)
%Find the integral of the time_series from the Reaction Time point for a
%time window (tw). A tw of 60 time points correspond to 200 ms

time_series_of_interest = time_series(RT_tp:RT_tp+tw);
tot_int = trapz(time_series_of_interest);

%Get rid of elevated rectangular
rect = tw * time_series(RT_tp);
ampl_resp = tot_int - rect; % mm 

%Plot integral range on time series
figure; hold on;
plot(time_series)
hold on;
line([RT_tp, RT_tp], [0, 20], 'Color', 'r', 'LineWidth', 1);
line([RT_tp+tw, RT_tp+tw], [0, 20], 'Color', 'r', 'LineWidth', 1);



