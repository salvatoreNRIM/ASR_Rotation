% Load, preprocess and plot raw data, output is matrix with raw data, RT_ms, RT_tp

%Example call analysis_script('ASR_B10_Ctrl_OFF', 'Front_L')
 
function [R, RT_ms, RT_tp] = analysis_script3(file_id, marker_id, colors, index_title)

matrix_magnVector = preprocess_data_1_mouse_1_marker_3(file_id, marker_id);

% Discard trials that do not fit criteria
data_matrix_thresh = discard_trials(matrix_magnVector);
if isempty(data_matrix_thresh)
    warning ('no good data!')
    R = -1;
else
    % Find RT
    [RT_tp, RT_ms] = find_RT(data_matrix_thresh);
    
    % Plot trials with RT
    plot_thresh_data_with_RT_3(data_matrix_thresh, RT_tp, colors, index_title);
    hold on;
    R = data_matrix_thresh;
end 

