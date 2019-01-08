% Load, preprocess and plot raw data, output is matrix with raw data

%Example call analysis_script('ASR_B10_Ctrl_OFF', 'Front_L')
 
function [R, RT_ms, RT_tp, amp_vector] = analysis_script2(file_id, marker_id)

matrix_magnVector = preprocess_data_1_mouse_1_marker(file_id, marker_id);

% Discard trials that do not fit criteria
data_matrix_thresh = discard_trials(matrix_magnVector);
if isempty(data_matrix_thresh)
    warning ('no good data!')
    R = -1;
else
    % Find RT
    [RT_tp, RT_ms] = find_RT(data_matrix_thresh);
    
    % Plot trials with RT
    plot_thresh_data_with_RT(data_matrix_thresh, RT_tp);
    R = data_matrix_thresh;
end 

% Find integral for 200 ms after RT (measure of amplitude of response)

amp_vector = zeros(1,size(R,1));

for i = 1:size(R,1)
   if RT_tp(i) > 0 
       amp_vector(i) = find_integral_tw(R(i,:), RT_tp(i), 60); 
   else
       warning ('no good data!')
   end
end



