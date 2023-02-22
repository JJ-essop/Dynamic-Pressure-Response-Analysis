function Exp_1_1_2_TubeLength_Repeats()

    foldername = 'G:\01 - Aero Projects\06 - FS Data\Pressure Response Anaysis\1 - Experimental Tests\1.1 - Tube Properties\1.1.2 - Tube Length\';

    raw_data_rpts{1} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_0m.xlsx'], 'Single value' );
    raw_data_rpts{2} = xlsread( [foldername, 'Repeats\LongLengthHypo_2022_12_01_1_0m_r2.xlsx'], 'Single value' );
    raw_data_rpts{3} = xlsread( [foldername, 'Repeats\LongLengthHypo_2022_12_01_1_0m_r3.xlsx'], 'Single value' );
    raw_data_rpts{4} = xlsread( [foldername, 'Repeats\LongLengthHypo_2022_12_01_1_0m_r4.xlsx'], 'Single value' );
    raw_data_rpts{5} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_2m.xlsx'], 'Single value' );
    raw_data_rpts{6} = xlsread( [foldername, 'Repeats\LongLengthHypo_2022_12_01_1_2m_r2.xlsx'], 'Single value' );
    raw_data_rpts{7} = xlsread( [foldername, 'Repeats\LongLengthHypo_2022_12_01_2m_r2.xlsx'], 'Single value' );
    raw_data_rpts{8} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_2m.xlsx'], 'Single value' );
    raw_data_rpts{9} = xlsread( [foldername, 'Repeats\LongLengthHypo_2022_12_01_2m_r3.xlsx'], 'Single value' );

    experiment_1_response = struct();

    for i = 1:length(raw_data_rpts)
        experiment_1_response(i).amp = raw_data_rpts{i}(1,1:251);
        experiment_1_response(i).phase = rad2deg(raw_data_rpts{i}(2,1:251)*-1);
        experiment_1_response(i).frequency = 0:1:250;
    end
   
    figure;
    set(gcf,'position',[500,300,1000,600]);
    for j = 1:4
        ax1 = subplot(2,1,1);
        plot(ax1,experiment_1_response(j).frequency, experiment_1_response(j).amp);
        hold on
        grid(ax1,'on')
        xlabel('Frequency [Hz]')
        % set(ax1,'XTick',[0:50:300])
        ylabel('Amplitude ratio')
        title('Dynamic Pressure Response of ID = 1.37mm')
        
        if j == 1
            legend('L = 1m - repeat 1')
        elseif j == 2
            legend('L = 1m - repeat 1', 'L = 1m - repeat 2')
        elseif j == 3
            legend('L = 1m - repeat 1', 'L = 1m - repeat 2', 'L = 1m - repeat 3')
        elseif j == 4
            legend('L = 1m - repeat 1', 'L = 1m - repeat 2', 'L = 1m - repeat 3', 'L = 1m - repeat 4')
        end
        
        ax2 = subplot(2,1,2);
        plot(ax2,experiment_1_response(j).frequency, experiment_1_response(j).phase);
        hold on
        grid(ax2,'on')
        xlabel('Frequency [Hz]')
        % ylim([0 250])
        % set(ax2,'YTick',[0:50:250])
        set(ax2,'Ydir','reverse')
        ylabel('Pahse [deg]')
    end
    
    figure;
    set(gcf,'position',[500,300,1000,600]);
    for j = 5:6
        ax1 = subplot(2,1,1);
        plot(ax1,experiment_1_response(j).frequency, experiment_1_response(j).amp);
        hold on
        grid(ax1,'on')
        xlabel('Frequency [Hz]')
        % set(ax1,'XTick',[0:50:300])
        ylabel('Amplitude ratio')
        title('Dynamic Pressure Response of ID = 1.37mm')
        
        if j == 5
            legend('L = 1.2m - repeat 1')
        elseif j == 6
            legend('L = 1.2m - repeat 1', 'L = 1.2m - repeat 2')
        end
        
        ax2 = subplot(2,1,2);
        plot(ax2,experiment_1_response(j).frequency, experiment_1_response(j).phase);
        hold on
        grid(ax2,'on')
        xlabel('Frequency [Hz]')
        % ylim([0 250])
        % set(ax2,'YTick',[0:50:250])
        set(ax2,'Ydir','reverse')
        ylabel('Pahse [deg]')
    end
    
    figure;
    set(gcf,'position',[500,300,1000,600]);
    for j = 7:9
        ax1 = subplot(2,1,1);
        plot(ax1,experiment_1_response(j).frequency, experiment_1_response(j).amp);
        hold on
        grid(ax1,'on')
        xlabel('Frequency [Hz]')
        % set(ax1,'XTick',[0:50:300])
        ylabel('Amplitude ratio')
        title('Dynamic Pressure Response of ID = 1.37mm')
        
        if j == 7
            legend('L = 2m - repeat 1')
        elseif j == 8 
            legend('L = 2m - repeat 1', 'L = 2m - repeat 2')
         elseif j == 9 
            legend('L = 2m - repeat 1', 'L = 2m - repeat 2', 'L = 2m - repeat 3')        
        end
        
        ax2 = subplot(2,1,2);
        plot(ax2,experiment_1_response(j).frequency, experiment_1_response(j).phase);
        hold on
        grid(ax2,'on')
        xlabel('Frequency [Hz]')
        % ylim([0 250])
        % set(ax2,'YTick',[0:50:250])
        set(ax2,'Ydir','reverse')
        ylabel('Pahse [deg]')
    end
end

