function [x] = plot_labeled_markers_over_time(data,labels,samples_of_interest)
% Plot labeled markers over time.
% 
% Inputs:
%    data:                     Motion capture data structure. 
%    labels:                   An m x n cell array containing the label names
%                              of the markers/data to plot. 
%                              With:
%                              m:   The number of markers per-subplot
%                              n:   The number of subplots.
%
%    samples_of_interest:      Samples to be plotted. 
%    dim_to_plot:              Dimension to be plotted, ('x', 'y' or 'z')
%
%
% Example:   
%             % Defined which samples need to be plotted
%             samples_of_interest=1:(20*300);
% 
%             % Define which markers should be plotted, 
%             % columns: number of sub-plots; rows: markers per subplot.
%             % For unqual numbers of markers per subplots, enter an empty
%             % string if nothing is to be plotted. 
%             labels=[{'ankle_l'},{'knee_l'};...
%                     {'ankle_r'},  {''}    ];
% 
%             plot_labeled_markers_over_time(data,labels,samples_of_interest,'z')
%                                       
% Author: Alexander Kuck, Neural Rhythms in Movement Unit, OIST, Okinawa
% Date: 01.06.2018


    
    fs=data{5,2}; %frequency
    working_data= data{21,1};
    working_data_labels = data{7,2};

    
    time=(samples_of_interest-samples_of_interest(1))/fs; %centre around 0 for x axis
    ax=zeros(1,length(labels));
    global toplot
    
    title_text='Markers:';
        for j=1:size(labels,1)
            idx=[];
            for l=1:length(working_data_labels)
                if strfind(labels, working_data_labels{l})
                    idx=l;
                end
            end
            
            if ~isempty(idx)
                title_text=[title_text ' ' labels];
                toplot=squeeze(working_data(idx,samples_of_interest));
                %plot(time,toplot,'k')
                if j<size(labels,2)
                    title_text=[title_text ','];
                end
            else
                title_text=title_text(1:(end-1));
            end
        end
        
        %title(title_text)
        %ylabel(['displacement [mm]'])
        
        
        x = toplot;