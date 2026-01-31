% filepath: ../musclelab/musclelab.m
scriptDir = fileparts(mfilename('fullpath'));
dataFolder = fullfile(scriptDir, 'Data');
files = dir(fullfile(dataFolder, '*.txt'));

s = settings;
s.matlab.appearance.figure.GraphicsTheme.TemporaryValue = "light";

plotsFolder = fullfile(scriptDir, 'plots');
if ~exist(plotsFolder, 'dir')
   mkdir(plotsFolder);
end

% Figure for each file
for i = 1:length(files)
    filePath = fullfile(dataFolder, files(i).name);
    data = readtable(filePath, 'Delimiter', ',');
    
    time = data{:, 1};
    voltage = data{:, 2};

    [~, name, ~] = fileparts(files(i).name);

    f = figure;
    plot(time, voltage, 'b-');
    hold on;
    xlabel('Time (s)');
    ylabel('Voltage (V)');
    title(sprintf('%s', name));
    legend('Plot', 'Data Points');
    grid on;


    % Peak detection algo: 
    % find start and stop of voltage spikes by throwing a threshold around a point and seeing if the next point
    % is outside that threshold
    voltageThreshold = 0.2;  % Threshold for spike detection
    peakStartAndStop = [];   % [start_time, stop_time; start_time, stop_time; ...]
    inSpike = false;
    spikeStart = 0;

    if i==1
        voltageThreshold = 0.15;  % Smaller value works better for the first graph
    end

    if i == 6
        voltageThreshold = 0.13;  % Adjust threshold for specific file if needed
    end
    
    for k = 2:length(voltage)
        % Detect transition from below to above threshold (spike start)
        if ~inSpike && voltage(k) > voltageThreshold && voltage(k-1) <= voltageThreshold
            spikeStart = time(k-1);
            inSpike = true;
        % Detect transition from above to below threshold (spike end)
        elseif inSpike && voltage(k) <= voltageThreshold && voltage(k-1) > voltageThreshold
            spikeStop = time(k);
            peakStartAndStop = [peakStartAndStop; spikeStart, spikeStop];
            inSpike = false;
        end
    end
    
    % Case: Spike extends to end of data
    if inSpike
        peakStartAndStop = [peakStartAndStop; spikeStart, time(end)];
    end

    % After calculating peakStartAndStop, filter by amplitude
    minAmplitude = 0.4;  % Only keep spikes with max voltage > this value
    if i==1
        minAmplitude = 0.25;  % Only keep spikes with max voltage > this value
    end
    validSpikes = [];

    for k = 1:size(peakStartAndStop, 1)
        spikeRegion = voltage(time >= peakStartAndStop(k, 1) & time <= peakStartAndStop(k, 2));
        if max(spikeRegion) > minAmplitude
            validSpikes = [validSpikes; peakStartAndStop(k, :)];
        end
    end
    peakStartAndStop = validSpikes;

    % Metrics for each activation
    activationMetrics = [];
    activationStdTimes = [];
    activationStdValues = [];
    activationMeanValues = [];
    activationRangeValues = [];
    if ~isempty(peakStartAndStop)
        for k = 1:size(peakStartAndStop, 1)
            % Get voltage data within activation window
            activationMask = time >= peakStartAndStop(k, 1) & time <= peakStartAndStop(k, 2);
            activationVoltage = voltage(activationMask);
            activationTime = time(activationMask);
            
            meanVoltage = mean(activationVoltage);
            stdVoltage = std(activationVoltage);
            rangeVoltage = max(activationVoltage) - min(activationVoltage);
            
            [~, peakIdx] = max(activationVoltage);
            timeToFeak = activationTime(peakIdx) - peakStartAndStop(k, 1);
            activationMidTime = mean(activationTime);
            activationStdTimes = [activationStdTimes; activationMidTime];
            activationStdValues = [activationStdValues; stdVoltage];
            activationMeanValues = [activationMeanValues; meanVoltage];
            activationRangeValues = [activationRangeValues; rangeVoltage];
            
            activationMetrics = [activationMetrics; ...
                peakStartAndStop(k, 1), peakStartAndStop(k, 2), ...
                meanVoltage, stdVoltage, rangeVoltage, timeToFeak];
        end
        
        % Display metrics table in the cli
        metricsTable = table(...
            activationMetrics(:, 1), ...
            activationMetrics(:, 2), ...
            activationMetrics(:, 3), ...
            activationMetrics(:, 4), ...
            activationMetrics(:, 5), ...
            activationMetrics(:, 6), ...
            'VariableNames', {'Start_Time_s', 'Stop_Time_s', 'Mean_Voltage_V', 'Std_Dev_V', 'Range_V', 'Time_to_Peak_s'});
        disp(['File: ', files(i).name]);
        disp(metricsTable);
        disp(' ');
        
        % Export metrics to a CSV
        [~, name, ~] = fileparts(files(i).name);
        csvFilename = fullfile(plotsFolder, [name, '_metrics.csv']);
        writetable(metricsTable, csvFilename);

        % standard deviation and mean vs peak number for activations and export
        if ~isempty(activationStdTimes)
            g = figure;
            numPeaks = length(activationStdValues);
            peakNumbers = 1:numPeaks;
            plot(peakNumbers, activationStdValues, 'o-','LineWidth',1.5);
            hold on;
            plot(peakNumbers, activationMeanValues, 's-','LineWidth',1.5);
            if ~isempty(activationRangeValues)
                plot(peakNumbers, activationRangeValues, 'd-','LineWidth',1.5);
            end
            
            % Add data values for each point
            if ~isempty(activationRangeValues)
                yRange = max([activationStdValues; activationMeanValues; activationRangeValues]) - min([activationStdValues; activationMeanValues; activationRangeValues]);
            else
                yRange = max([activationStdValues; activationMeanValues]) - min([activationStdValues; activationMeanValues]);
            end
            % vertical offset as fraction of y-range
            offset = yRange * 0.01;
            % horizontal offset 
            labelXOffset = 0.02;  % change this value to move labels further right/left
            for j = 1:numPeaks
                % Std dev: right of point, slightly above
                text(j + labelXOffset, activationStdValues(j) + offset, sprintf('%.3f', activationStdValues(j)), ...
                    'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', 8);
                % Mean: right of point, slightly below
                text(j + labelXOffset, activationMeanValues(j) - offset, sprintf('%.3f', activationMeanValues(j)), ...
                    'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontSize', 8);
                % Range: right of point, above both
                if ~isempty(activationRangeValues)
                    text(j + labelXOffset, activationRangeValues(j) + offset*2, sprintf('%.3f', activationRangeValues(j)), ...
                        'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontSize', 8);
                end
            end
            
            xlabel('Peak Number');
            ylabel('Voltage (V)');
            title(sprintf('%s - Std Dev, Mean and Range vs Peak Number', name));
            if ~isempty(activationRangeValues)
                legend('Std Dev', 'Mean Voltage', 'Range');
            else
                legend('Std Dev', 'Mean Voltage');
            end
            grid on;
            xticks(peakNumbers);
            stdPdf = fullfile(plotsFolder, [name, '_std_vs_time.pdf']);
            exportgraphics(g, stdPdf, 'ContentType', 'vector');
            close(g);
        end
    end

    % Mark the spike start and stop points on the graph
    if ~isempty(peakStartAndStop)
        scatter(peakStartAndStop(:, 1), interp1(time, voltage, peakStartAndStop(:, 1)), ...
                'g', 'filled', 'SizeData', 100, 'DisplayName', 'Spike Start');
        scatter(peakStartAndStop(:, 2), interp1(time, voltage, peakStartAndStop(:, 2)), ...
                'b', 'filled', 'SizeData', 100, 'DisplayName', 'Spike Stop');
        
        % Add peak numbers at the peaks
        for k = 1:size(peakStartAndStop, 1)
            activationMask = time >= peakStartAndStop(k, 1) & time <= peakStartAndStop(k, 2);
            activationVoltage = voltage(activationMask);
            activationTime = time(activationMask);
            [peakVoltage, peakIdx] = max(activationVoltage);
            peakTime = activationTime(peakIdx);
            timeToPeak = peakTime - peakStartAndStop(k, 1);
            text(peakTime, peakVoltage, sprintf('Peak %d (%.3f s)', k, timeToPeak), ...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 10, 'FontWeight', 'bold');
        end
        
        legend;
    end
    
    pdfFilename = fullfile(plotsFolder, [name, '.pdf']);
    
    % Export the current figure to PDF
    exportgraphics(f, pdfFilename, 'ContentType', 'vector');

    hold off;
end
