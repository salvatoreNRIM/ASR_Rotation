%% Load, preprocess and plot raw data

% Example call: plot_vector_1_mouse_1_marker('ASR_R7_Exp_OFF', 'Tail_1');

function [matrix_magnVector] = preprocess_data_1_mouse_1_marker(id_mouse, id_marker)

[UnrolledCell, first_idx] = load_file_mat(id_mouse);

% hold on;
%plotStyle = {'b','k','r','g','m','c',[0, 0.75, 0.75], [0.6350, 0.0780, 0.1840]};%,'k.','r.','g.','m.'}; % add as many as you need

t_max = 150;
%idx_legend = 1:10;
%matrix_magnVector = zeros(length(first_idx),301+t_max);

%initialize some variables
list_labels = UnrolledCell{7,2};
startleWindowPre_length = 0.5; % in seconds
startleWindowPost_length = 0.5;
fs = UnrolledCell{5,2};

matrix_magnVector = zeros(length(first_idx),301+t_max);



    %loop through the 10 trials
    figure; hold on
    for i = 1:length(first_idx)
        firstStartleWinSample = round(first_idx(i) - startleWindowPre_length * fs);
        lastStartleWinSample = round(first_idx(i) + startleWindowPost_length * fs+t_max);
        samples_of_interest = (firstStartleWinSample:lastStartleWinSample);

        
        %trial_beg = round(first_idx(i));
        %legendInfo{idx_legend(i)} = ['Trial ' num2str(i)]
        %plot_magnitude_vector(UnrolledCell, labels, samples_of_interest, trial_beg)%, iter);
        matrix_magnVector(i,:) = plot_labeled_markers_over_time(UnrolledCell,id_marker,samples_of_interest);
        
        
    end
    hold off