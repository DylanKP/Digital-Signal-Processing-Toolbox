function cfa_save(filename, s)
    if ~ischar(filename)
        error('Input must be a string');
    end
    if ~isstruct(s) && (~isfield(s, 'signalMatrixData') || ~isfield(s, 'samplingRateData') || ~isfield(s, 'channelCount') || ~isfield(s, 'bitDepthData') || ~isfield(s, 'fileNameData'))
        error('Input must be a struct');
    end

    if exist(filename, 'file')
        warning('File already exists. Overwriting...');
    end

    if strcmp(filename(end-3:end), '.wav') || strcmp(filename(end-4:end), '.flac') || strcmp(filename(end-3:end), '.ogg')
        audiowrite(filename, s.signalMatrixData, s.samplingRateData);
        disp('File saved successfully');

    else
        error('File is in invalid format');
    end
end