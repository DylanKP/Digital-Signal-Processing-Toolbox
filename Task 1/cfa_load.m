function s = cfa_load(filename)
    if nargin < 1
        error('Usage: cfa_load(filename). Please provide a filename.');
    end

    if ~ischar(filename)
        error('Input must be a string');
    end
    if ~exist(filename, 'file')
        error('File does not exist');
    end
    if ~strcmp(filename(end-3:end), '.wav') && ~strcmp(filename(end-4:end), '.flac') && ~strcmp(filename(end-3:end), '.ogg')
        error('File is in invalid format');
    end


    [signalMatrix, samplingRate] = audioread(filename);
    audioInfoData = audioinfo(filename);

    s = struct();

    s.signalMatrixData = signalMatrix;
    s.samplingRateData = samplingRate;
    s.channelCount = size(signalMatrix, 2);
    s.fileNameData = filename;

    if isfield(audioInfoData, 'BitsPerSample')
        s.bitDepthData = audioInfoData.BitsPerSample;
    else
        s.bitDepthData = NaN;
    end

    disp('File loaded successfully');
end