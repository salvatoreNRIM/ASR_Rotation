% Load, preprocess and plot raw data, output is matrix with raw data

%Example call analysis_script('ASR_B10_Ctrl_OFF', 'Front_L')

function analysis_script_all_markers(file_id, marker_id)

matrix_magnVector = preprocess_data_1_mouse_all_Markers(file_id);

% Discard trials that do not fit criteria 
data_matrix_thresh = discard_trials(matrix_magnVector);

% Find RT
[RT_tp, RT_ms] = find_RT(data_matrix_thresh);

% Plot trials with RT
plot_thresh_data_with_RT(data_matrix_thresh, RT_tp)