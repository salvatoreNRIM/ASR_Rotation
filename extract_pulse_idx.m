%Load pulses time and MoCap data
load('ASR_B10_Ctrl_ON.mat')
data = Startle_dark_7_12_B19.Trajectories.Labeled.Data;
tp = Startle_dark_7_12_B19.Analog.Data;
fs= Startle_dark_7_12_B19.FrameRate;

%Smooth data
g = gausswin(30);
g = g/sum(g);
smooth_data = Startle_dark_7_12_B19;
for i = 1:size(data,1)
    for j = 1:size(data,2)-1
        smooth_data.Trajectories.Labeled.Data(i,j,:) = conv(squeeze(data(i,j,:)),g,'same');
    end
end

%Extract time of pulses

idx_pulses = find(tp>0.9);
TTL_steps = diff(tp);
first_idx = find(TTL_steps > 0.5);
first_idx = first_idx / 10; % to account for different sample rate for TTL
%first_idx = idx_pulses(logical([1, diff(idx_pulses) ~= 1]));

%Extract timewindow of interest e.g. -3s to +5s for knee_l and hip_l (4 and 2 respectively)
%lab4 = squeeze(data(4,:,:));
%plot3(lab4(1,29878:29998), lab4(2,29878:29998), lab4(3,29878:29998))

labels = [{'hip_r'}]%,{'hip_r'},{'knee_r'},{'knee_l'},{'ankle_l'},{'ankle_r'},{'front_l'},{'front_r'}];
startleWindowPre_length = 0.5; % in seconds
startleWindowPost_length = 0.5;

%take derivative of data on one axis and one label
diff_data = smooth_data;
for i = 1:size(data,1)
    for j = 1:size(data,2)-1
        diff_data.Trajectories.Labeled.Data(i,j,:) = [0; squeeze(diff(data(i,j,:),1))];
    end
end

%Initialize matrix of magnitude of vector
diff_data.Trajectories.Labeled.Vector_Magnitude = zeros(size(data,1),size(data,3));
%extract magnitude of derivative vector
for i = 1:size(data,1)
       traj_matrix = squeeze(diff_data.Trajectories.Labeled.Data(i,1:3,:))';    
       diff_data.Trajectories.Labeled.Vector_Magnitude(i,:) = sqrt(sum(traj_matrix.^2, 2))';
end

%figure; 
hold on;
%plotStyle = {'b','k','r','g','m','b.','k.','r.','g.','m.'}; % add as many as you need
light_array = [2,3,5,6,7,8,9,10];
dark_array = [1,2,3,4,5,7,8,9,10];
for i = 1:length(first_idx)
    firstStartleWinSample = round(first_idx(i) - startleWindowPre_length * fs);
    lastStartleWinSample = round(first_idx(i) + startleWindowPost_length * fs);
    samples_of_interest = (firstStartleWinSample:lastStartleWinSample);
    %time=samples_of_interest/fs;
    
    trial_beg = round(first_idx(i));
%    figure()
%    hold on
    legendInfo{i} = ['Trial ' num2str(i)]; 
    a = plot_labeled_markers_over_time(smooth_data, labels, samples_of_interest, 'x', trial_beg);
    
end

line([0.5 0.5],get(gca, 'ylim'),'Color','red');
legend(legendInfo)
hold off
%legend([hbc{:}]);
%legend(legendInfo)
