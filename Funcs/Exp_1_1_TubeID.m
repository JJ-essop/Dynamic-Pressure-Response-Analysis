function PlotExp1()
    
    raw_data{1} = xlsread( 'G:\01 - Aero Projects\06 - FS Data\Pressure Response Anaysis\1 - Experimental Tests\1.1 - Tube Properties\1.1.1 - Tube Inner Diameter\Hypodermic tube testing results.xlsx', '0.68mm' );
    raw_data{2} = xlsread( 'G:\01 - Aero Projects\06 - FS Data\Pressure Response Anaysis\1 - Experimental Tests\1.1 - Tube Properties\1.1.1 - Tube Inner Diameter\Hypodermic tube testing results.xlsx', '1.12mm' );
    raw_data{3} = xlsread( 'G:\01 - Aero Projects\06 - FS Data\Pressure Response Anaysis\1 - Experimental Tests\1.1 - Tube Properties\1.1.1 - Tube Inner Diameter\Hypodermic tube testing results.xlsx', '1.37mm' );
    raw_data{4} = xlsread( 'G:\01 - Aero Projects\06 - FS Data\Pressure Response Anaysis\1 - Experimental Tests\1.1 - Tube Properties\1.1.1 - Tube Inner Diameter\Hypodermic tube testing results.xlsx', '2.058mm' );
    sheets = sheetnames('G:\01 - Aero Projects\06 - FS Data\Pressure Response Anaysis\1 - Experimental Tests\1.1 - Tube Properties\1.1.1 - Tube Inner Diameter\Hypodermic tube testing results.xlsx');
    
    experiment_1_response = struct();

    for i = 1:length(raw_data)
        experiment_1_response(i).amp = raw_data{i}(1:end,3);
        experiment_1_response(i).phase = raw_data{i}(1:end,5)*-1;
        experiment_1_response(i).frequency = raw_data{i}(1:end,1);
        experiment_1_response(i).tube_radius = sheets(i);
    end

    for j = i = 1:length(raw_data)
%         figure;
        ax1 = subplot(2,1,1);
        plot(ax1,experiment_1_response(j).frequency, experiment_1_response(j).amp);
        grid(ax1,'on')
        xlabel('Frequency [Hz]')
        % set(ax1,'XTick',[0:50:300])
        ylabel('Amplitude ratio')
        ID = experiment_1_response(j).tube_radius;
        title(sprintf('Dynamic Pressure Response of ID = %s', ID))

        ax2 = subplot(2,1,2);
        plot(ax2,experiment_1_response(j).frequency, experiment_1_response(j).phase);
        grid(ax2,'on')
        xlabel('Frequency [Hz]')
        % ylim([0 250])
        % set(ax2,'YTick',[0:50:250])
        set(ax2,'Ydir','reverse')
        ylabel('Pahse [deg]')
        
    end
end