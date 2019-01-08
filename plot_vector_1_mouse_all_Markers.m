%Plot on each figure data for one marker and all the trials. There will be
%as many figures as markers
% Example call: plot_vector_1_mouse_1_marker('ASR_R7_Exp_OFF');

function [matrix_magnVector] = plot_vector_1_mouse_all_Markers(id_mouse)

[UnrolledCell, first_idx] = load_file_mat(id_mouse);


%initialize some variables
list_labels = UnrolledCell{7,2};
startleWindowPre_length = 0.5; % in seconds
startleWindowPost_length = 0.5;
fs = UnrolledCell{5,2};
t_max = 150;

%matrix of dimension: no_markers x no_trials x time_points
matrix_magnVector = zeros(length(list_labels),length(first_idx),301+t_max);


%loop through the markers
for j = 1:length(list_labels)
    %loop through the 10 trials
    figure; hold on;
    for i = 1:length(first_idx)
        firstStartleWinSample = round(first_idx(i) - startleWindowPre_length * fs);
        lastStartleWinSample = round(first_idx(i) + startleWindowPost_length * fs+t_max);
        samples_of_interest = (firstStartleWinSample:lastStartleWinSample);

        
        %trial_beg = round(first_idx(i));
        %legendInfo{idx_legend(i)} = ['Trial ' num2str(i)]
        %plot_magnitude_vector(UnrolledCell, labels, samples_of_interest, trial_beg)%, iter);
        matrix_magnVector(j,i,:) = plot_labeled_markers_over_time(UnrolledCell,cell2mat(list_labels(j)),samples_of_interest);
        
    end
    hold off
end