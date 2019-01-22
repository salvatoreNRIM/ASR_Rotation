function plot_thresh_data_with_RT_3(thresh_data, RT_tp, color, index_title)
Title_Cond = {'Ctrl ON', 'Ctrl OFF', 'Exp ON', 'Exp OFF'};

[~, ~, h] = find_time_to_peak3(thresh_data, RT_tp);

for i =1:size(thresh_data,1)
    %This is to plot normal traces
    plot(thresh_data(i,:), color) 
    ylim([0 120])
    title(Title_Cond(index_title))
%     
%     %This is to plot scaled traces
%     trace = thresh_data(i,:);    
%     scaled_trace = trace./(h(i));
%     plot(scaled_trace, color)
%     ylim([0,2]);
%     title(Title_Cond(index_title))
%     
%     
% %     if RT_tp(i) ~= 0
% %         hold on
% %         plot(thresh_data(i,:), color)
% %         hold on ; plot(RT_tp(i),thresh_data(i,RT_tp(i)))
% %     else
% %        plot(thresh_data(i,:), color) 
% %        %hold on ; plot(RT_tp(i),thresh_data(i,RT_tp(i)),'r*')
% %     end
end
