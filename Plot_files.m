%Plot on each figure data for one marker and all the trials. There will be
%as many figures as markers

function plot_vector_1_mouse(id_mouse)
load_file_mat(id_mouse)
figure; 
% hold on;
%plotStyle = {'b','k','r','g','m','c',[0, 0.75, 0.75], [0.6350, 0.0780, 0.1840]};%,'k.','r.','g.','m.'}; % add as many as you need

t_max = 150;
%idx_legend = 1:10;
%matrix_magnVector = zeros(length(first_idx),301+t_max);

%iter = 0;
%loop through the markers
list_labels = UnrolledCell{7,2};
for j = list_labels
    %loop through the 10 trials
    figure
    for i = 1:length(first_idx)
        firstStartleWinSample = round(first_idx(i) - startleWindowPre_length * fs);
        lastStartleWinSample = round(first_idx(i) + startleWindowPost_length * fs+t_max);
        samples_of_interest = (firstStartleWinSample:lastStartleWinSample);

    
        %trial_beg = round(first_idx(i));
        %legendInfo{idx_legend(i)} = ['Trial ' num2str(i)]
        %plot_magnitude_vector(UnrolledCell, labels, samples_of_interest, trial_beg)%, iter);
        plot_labeled_markers_over_time(UnrolledCell,cell2mat(j),samples_of_interest)
    
    end
end