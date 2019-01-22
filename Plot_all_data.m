Exp_Cond = {'Ctrl_ON', 'Ctrl_OFF', 'Exp_ON', 'Exp_OFF'};
Animal_ID = {'B10', 'C9', 'N8', 'R7'};
colors = {'m','c','r','g'};


for i = 1:4
    for j = 1:4

        data_to_plot = ['ASR_', Animal_ID(j), '_', Exp_Cond(i)];
        array_to_plot = regexprep([data_to_plot{:}],'\s+','_');
        [R, RT_ms, RT_tp] = analysis_script3(array_to_plot, 'Back_L', cell2mat(colors(i)));
        
    end
    
end

h = zeros(4, 1);
h(1) = plot(NaN,NaN,'om');
h(2) = plot(NaN,NaN,'oc');
h(3) = plot(NaN,NaN,'or');
h(4) = plot(NaN,NaN,'og');

legend(h, 'Ctrl ON', 'Ctrl OFF', 'Exp ON', 'Exp OFF');
