%Load pulses time and MoCap data
load('ASR_R7_Ctrl_ON.mat')
%data = ASR_C9_Exp_ON.Trajectories.Labeled.Data;
Exp_ID = ASR_R7_Ctrl_ON;
tp = Exp_ID.Analog.Data;
fs= Exp_ID.FrameRate;

idx_pulses = find(tp>0.9);
TTL_steps = diff(tp);
first_idx = find(TTL_steps > 0.5);
first_idx = first_idx / 7; % to account for different sample rate for TTL (7 Hz)

% pathname = fileparts('\ASR_second\B10\Light_Ctrl\');
% filename = fullfile(pathname, 'TTL_delivery_times');
% csvwrite(filename, first_idx)