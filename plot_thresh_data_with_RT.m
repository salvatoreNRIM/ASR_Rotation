function plot_thresh_data_with_RT(thresh_data, RT_tp)

for i =1:size(thresh_data,1)
    if RT_tp(i) ~= 0
        plot(thresh_data(i,:))
        hold on ; plot(RT_tp(i),thresh_data(i,RT_tp(i)),'r*')
    else
       plot(thresh_data(i,:)) 
       %hold on ; plot(RT_tp(i),thresh_data(i,RT_tp(i)),'r*')
    end
end
