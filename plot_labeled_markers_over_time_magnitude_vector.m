function [x] = plot_labeled_markers_over_time_magnitude_vector(data,labels,samples_of_interest,trial_beg)%, iter)
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

% 
%     switch dim_to_plot
%         case 'x'
%             dim=1;
%         case 'y'
%             dim=2;
%         case 'z'
%             dim=3;
%     end

% % parameter for filtering
%     d = fdesign.lowpass('Fp,Fst,Ap,Ast',3,5,0.5,40,100);
%     Hd = design(d,'equiripple');

% %parameter for smoothing
%     g = gausswin(40); % <-- this value determines the width of the smoothing window
%     g = g/sum(g);
    
    fs=300;
    
    %[working_data, working_data_labels] = generate_working_data(data);
    working_data= data{21,1};
    working_data_labels = data{7,2};

    plotStyle = {'b','k','r','g','m','c', [0, 0.75, 0.75], [0.6350, 0.0780, 0.1840],[0.75, 0.75, 0], [0, 0.5, 0]};
    time=(samples_of_interest-samples_of_interest(1))/fs;
    ax=zeros(1,length(labels));
    global toplot
    %figure; hold on
    for i=1:size(labels,2)
        ax(i)=subplot(length(labels),1,i); %hold on;
        title_text='Markers:';
        for j=1:size(labels,1)
            idx=[];
            for l=1:length(working_data_labels)
                if strfind(labels{j,i},working_data_labels{l})
                    idx=l;
                end
            end
            
            if ~isempty(idx)
                title_text=[title_text ' ' labels{j,i}];
                %no smooth
                toplot=squeeze(working_data(idx,samples_of_interest));
                %smoothed
                %toplot=conv(squeeze(working_data(idx,samples_of_interest)),g,'same');
        

                %allign trials on y axis
                %toplot = toplot- toplot(151);


                %legendInfo{i} = ['X = ' num2str(i)];
                plot(time,toplot, 'LineWidth',1);%,'color',plotStyle{iter});%plotStyle{iter}); %[ 0.9100 0.4100 0.1700]);%
                %hb = plot(time,toplot, 'LineWidth',1);
                %hbc = get(hb);
                %legend([hbc{:}]);
                stim_index = trial_beg-samples_of_interest(1);
                   stim_pos_value = toplot(stim_index); 
                
%                  if (~isnan(stim_pos_value))
%                  ylim([0 1]);
%                  end
                
                %xlim([0,1.5]); 
                
                %added line
                
                %line([stim_index/fs + time(1) stim_index/fs  + time(1)], get(gca, 'ylim'),'Color','red');
                
                %finish adding line
                
                if j<size(labels,2)
                    title_text=[title_text ','];
                end
            else
                title_text=title_text(1:(end-1));
            end
        end
        
        %title((title_text), 'FontSize',20)
        xlabel([ 'time (s)'], 'FontSize',20)
        set(gca, 'FontSize', 14)
        ylabel([ 'distance from origin (mm)'], 'FontSize',20)
    end
    x = toplot;
    linkaxes(ax,'x')
