function s = cfa_load(filename)
    % This function loads an audio file
    % The function takes a filename as input and returns a struct containing the audio signal and metadata
    % The struct contains the fields signalMatrixData, samplingRateData, channelCount, fileNameData, and bitDepthData (if available)
    % cfa_load(filename)

    % Check if the filename is provided
    if nargin < 1
        error('Usage: cfa_load(filename). Please provide a filename.');
    end

    % Check if the input is a string
    if ~ischar(filename)
        error('Input must be a string');
    end
    % Check if the file exists
    if ~exist(filename, 'file')
        error('File does not exist');
    end
    % Check if the file format is valid
    if ~strcmp(filename(end-3:end), '.wav') && ~strcmp(filename(end-4:end), '.flac') && ~strcmp(filename(end-3:end), '.ogg')
        error('File is in invalid format');
    end


    % Load the audio file
    [signalMatrix, samplingRate] = audioread(filename);
    audioInfoData = audioinfo(filename);

    % Create a struct to store the audio data
    s = struct();

    % Store the audio data in the struct
    s.signalMatrixData = signalMatrix;
    s.samplingRateData = samplingRate;
    s.channelCount = size(signalMatrix, 2);
    s.fileNameData = filename;

    % Store the bit depth if available
    if isfield(audioInfoData, 'BitsPerSample')
        s.bitDepthData = audioInfoData.BitsPerSample;
    else
        s.bitDepthData = NaN;
    end

    disp('File loaded successfully');
end