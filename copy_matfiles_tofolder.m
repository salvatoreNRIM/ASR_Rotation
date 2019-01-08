%Move .mat files in a folder

dirData = dir('**/*.mat'); %list .mat files in dirData struct

for i = 1:length(dirData)
    name_file = dirData(i).name;
    folder_file = dirData(i).folder;
    path_file = [folder_file, '/', name_file];
    copyfile(path_file, 'Mat_data');

    
end