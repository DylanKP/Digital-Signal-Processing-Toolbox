function cfa_save(filename, s)
    % This function saves the audio signal to a file
    % The function takes a filename and a struct s as input
    % The struct s must contain the fields signalMatrixData, samplingRateData, channelCount, bitDepthData, and fileNameData
    % The function saves the audio signal to the specified file in the format specified by the file extension
    % cfa_save(filename, s)

    % Check if the input is a string
    if ~ischar(filename)
        error('Input must be a string');
    end
    % Check if the struct is provided
    if ~isstruct(s) && (~isfield(s, 'signalMatrixData') || ~isfield(s, 'samplingRateData') || ~isfield(s, 'channelCount') || ~isfield(s, 'bitDepthData') || ~isfield(s, 'fileNameData'))
        error('Input must be a struct');
    end

    % Check if the file already exists
    if exist(filename, 'file')
        warning('File already exists. Overwriting...');
    end

    % Save the audio signal to the file
    if strcmp(filename(end-3:end), '.wav') || strcmp(filename(end-4:end), '.flac') || strcmp(filename(end-3:end), '.ogg')
        audiowrite(filename, s.signalMatrixData, s.samplingRateData);
        disp('File saved successfully');

    else
        % Display an error if the file format is invalid
        error('File is in invalid format');
    end
end