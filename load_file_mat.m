%Load data .mat
%Starting directory: ASR_second_preproc
%cd Mat_data
function [x, first_idx] = load_file_mat(mouse_id)
dirData = dir('**/*.mat'); %list .mat files in dirData struct

%Initialize variables
%Data_Struct = load(dirData(1).name);
Data_Struct = load(mouse_id);
%file_id = fieldnames(Data_Struct);
[UnrolledCell] = getUnrolledVal(Data_Struct,[]);
data = UnrolledCell{8,2};
tp = UnrolledCell{20,2};




%Smoothing data
t_max = 150;
g = gausswin(9);
g = g/sum(g);
smooth_data = data;
for i = 1:size(data,1)
    for j = 1:size(data,2)-1
        smooth_data(i,j,:) = conv(squeeze(data(i,j,:)),g,'same');
    end
end


%Extract time of pulses
idx_pulses = find(tp>0.9);
TTL_steps = diff(tp);
first_idx = find(TTL_steps > 0.5);
first_idx = first_idx / 7; % to account for different sample rate for TTL


%Initialize markers ID and TimeWindow to look at
% labels = [{'hip_l'}];%,{'hip_r'}];%,{'knee_r'},{'knee_l'},{'ankle_l'},{'ankle_r'},{'front_l'},{'front_r'}];
% startleWindowPre_length = 0.5; % in seconds
% startleWindowPost_length = 0.5;


%Centre the position to 0 for each axis for each trial with respect to y ax
centred_smooth_data = smooth_data;
data = smooth_data;
for i = 1:size(data,1) %loop through markers
    for j = 1:size(data,2)-1  %loop through axis x,y,z
        for k = round(first_idx)%loop through trials'segment
            data_0 = centred_smooth_data(i,j,k);
            centred_smooth_data(i,j,(k-155):(k+150+t_max)) = data(i,j,(k-155):(k+150+t_max))-data_0;
        end
    end
end


%take derivative of data on one axis and one label
diff_data = centred_smooth_data;
data = centred_smooth_data;
for i = 1:size(data,1)
    for j = 1:size(data,2)-1
        diff_data(i,j,:) = [0; squeeze(diff(data(i,j,:),1))];
    end
end


%extract magnitude of derivative vector of position
int_data_space = centred_smooth_data;
UnrolledCell{21,1} = zeros(size(data,1),size(data,3));
magn_vect_matrix = UnrolledCell{21,1};

for i = 1:size(data,1)
       traj_matrix = squeeze(int_data_space(i,1:3,:))';    
       magn_vect_matrix(i,:) = sqrt(sum(traj_matrix.^2, 2))';
end

UnrolledCell{21,1} = magn_vect_matrix;
x = UnrolledCell;