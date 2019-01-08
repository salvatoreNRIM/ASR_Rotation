
%loop through all the markers of one session
%Example call = loop_through_markers('ASR_B10_Ctrl_OFF')
function loop_through_markers(file_id)
Data_Struct = load(file_id);
UnrolledCell = getUnrolledVal(Data_Struct,[]);
labels_id = UnrolledCell{7,2};

for i = 1:length(labels_id)
    analysis_script_all_markers(file_id, labels_id(i));
    
end