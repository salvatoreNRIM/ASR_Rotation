function scale_traces(R,h)

figure;
for i = 1:size(R,1)
    trace = R(i,:);
    scaled_trace = trace./(h(i));
    hold on; plot(scaled_trace)
    ylim([0,2]);
end
