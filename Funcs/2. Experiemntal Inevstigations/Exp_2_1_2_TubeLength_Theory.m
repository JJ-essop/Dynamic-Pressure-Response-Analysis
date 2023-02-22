function Exp_2_1_2_TubeLength_Theory()

    tube_length = [2: -0.1: 0.2];

    foldername = 'G:\01 - Aero Projects\06 - FS Data\Pressure Response Anaysis\1 - Experimental Tests\1.1 - Tube Properties\1.1.2 - Tube Length\';
    
    raw_data{1} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_2m.xlsx'], 'Single value' );
    raw_data{2} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_9m.xlsx'], 'Single value' );
    raw_data{3} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_8m.xlsx'], 'Single value' );
    raw_data{4} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_7m.xlsx'], 'Single value' );
    raw_data{5} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_6m.xlsx'], 'Single value' );
    raw_data{6} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_5m.xlsx'], 'Single value' );
    raw_data{7} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_4m.xlsx'], 'Single value' );
    raw_data{8} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_3m.xlsx'], 'Single value' );
    raw_data{9} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_2m.xlsx'], 'Single value' );
    raw_data{10} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_1m.xlsx'], 'Single value' );
    raw_data{11} = xlsread( [foldername, 'LongLengthHypo_2022_12_01_1_0m.xlsx'], 'Single value' );
    raw_data{12} = xlsread( [foldername, 'LongLengthHypo_2022_12_05_0_9m.xlsx'], 'Single value' );
    raw_data{13} = xlsread( [foldername, 'LongLengthHypo_2022_12_05_0_8m.xlsx'], 'Single value' );
    raw_data{14} = xlsread( [foldername, 'LongLengthHypo_2022_12_05_0_7m.xlsx'], 'Single value' );
    raw_data{15} = xlsread( [foldername, 'LongLengthHypo_2022_12_05_0_6m.xlsx'], 'Single value' );
    raw_data{16} = xlsread( [foldername, 'LongLengthHypo_2022_12_05_0_5m.xlsx'], 'Single value' );
    raw_data{17} = xlsread( [foldername, 'LongLengthHypo_2022_12_05_0_4m.xlsx'], 'Single value' );
    raw_data{18} = xlsread( [foldername, 'LongLengthHypo_2022_12_05_0_3m.xlsx'], 'Single value' );
    raw_data{19} = xlsread( [foldername, 'LongLengthHypo_2022_12_05_0_2m.xlsx'], 'Single value' );
    
    experiment_1_response = struct();

    for i = 1:length(raw_data)
        experiment_1_response(i).amp = raw_data{i}(1,1:251);
        experiment_1_response(i).phase = rad2deg(raw_data{i}(2,1:251)*-1);
        experiment_1_response(i).frequency = 0:1:250;
        experiment_1_response(i).tube_length = num2str(2.1-i*0.1);
    end

    for j = 1:length(raw_data)
        [complex_pressure_ratio, freqs] = Theory_1_1_1_FrequencySweep(tube_length(j), 0.000685, [0:1:250]);

        figure;
        set(gcf,'position',[500,300,1000,600]);
        ax1 = subplot(2,1,1);
        plot(ax1,experiment_1_response(j).frequency, experiment_1_response(j).amp);
        hold on
        plot(ax1, freqs, abs(complex_pressure_ratio))
        grid(ax1,'on')
        xlabel('Frequency [Hz]')
        % set(ax1,'XTick',[0:50:300])
        ylabel('Amplitude ratio')
        L = experiment_1_response(j).tube_length;
        title(['Dynamic Pressure Response of L = ', L, 'm'])
        legend('Experimental Result', 'Theoretical Result')
        
        ax2 = subplot(2,1,2);
        plot(ax2,experiment_1_response(j).frequency, experiment_1_response(j).phase);
        hold on
        plot(ax2, freqs, rad2deg(angle(complex_pressure_ratio))*-1)
        grid(ax2,'on')
        xlabel('Frequency [Hz]')
        % ylim([0 250])
        % set(ax2,'YTick',[0:50:250])
        set(ax2,'Ydir','reverse')
        ylabel('Pahse [deg]')
    end
end

