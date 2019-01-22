Exp_Cond = {'Ctrl_ON', 'Ctrl_OFF', 'Exp_ON', 'Exp_OFF'};
Title_Cond = {'Ctrl ON', 'Ctrl OFF', 'Exp ON', 'Exp OFF'};
Animal_ID = {'B10', 'C9', 'N8', 'R7'};
colors = {'m','c','r','g'};
h = zeros(4, 1);
h(1) = plot(NaN,NaN,'om');
h(2) = plot(NaN,NaN,'oc');
h(3) = plot(NaN,NaN,'or');
h(4) = plot(NaN,NaN,'og');

%Initialize variables before for loop;
R = [];
Ctrl_ON = [];
Ctrl_OFF = [];
Exp_ON = [];
Exp_OFF = [];

%Loop through Experimental conditions
for i = 1:4
    subplot(2,2,i)
    %Loop through different animals trials
    for j = 1:4

        data_to_plot = ['ASR_', Animal_ID(j), '_', Exp_Cond(i)];
        array_to_plot = regexprep([data_to_plot{:}],'\s+','_');
        new_row = R;
        [R, RT_ms, RT_tp] = analysis_script3(array_to_plot, 'Back_L', cell2mat(colors(i)), i);
        
        if i == 1
            if j == 1
                Ctrl_ON = cat(1, new_row, R);
            elseif j == 2
                Ctrl_ON_2 = cat(1, Ctrl_ON, R);
            elseif j == 3
                Ctrl_ON_3 = cat(1, Ctrl_ON_2, R);
            elseif j == 4
                Ctrl_ON_4 = cat(1, Ctrl_ON_3, R);
            end
            
            
        elseif i ==2
            if j == 1
                Ctrl_OFF = cat(1, new_row, R);
            elseif j == 2
                Ctrl_OFF_2 = cat(1, Ctrl_OFF, R);
            elseif j == 3
                Ctrl_OFF_3 = cat(1, Ctrl_OFF_2, R);
            elseif j == 4
                Ctrl_OFF_4 = cat(1, Ctrl_OFF_3, R);
            end
            
        elseif i ==3
            if j == 1
                Exp_ON = cat(1, new_row, R);
            elseif j == 2
                Exp_ON_2 = cat(1, Exp_ON, R);
            elseif j == 3
                Exp_ON_3 = cat(1, Exp_ON_2, R);
            elseif j == 4
                Exp_ON_4 = cat(1, Exp_ON_3, R);
            end            
            
        elseif i ==4
            if j == 1
                Exp_OFF = cat(1, new_row, R);
            elseif j == 2
                Exp_OFF_2 = cat(1, Exp_OFF, R);
            elseif j == 3
                Exp_OFF_3 = cat(1, Exp_OFF_2, R);
            elseif j == 4
                Exp_OFF_4 = cat(1, Exp_OFF_3, R);
            end            
          
            
        end
        
    end

end


