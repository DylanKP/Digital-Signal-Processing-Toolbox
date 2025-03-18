function sReversed = cfa_ext(s)
    % This function reverses the audio signal
    % The function takes a struct s as input, which must contain the field signalMatrixData
    % The function returns a struct sReversed with the reversed audio signal
    % cfa_ext(s)

    % Sets sReversed to a struct with the reversed signal matrix and the same sampling rate
    sReversed = struct();
    sReversed.signalMatrixData = flipud(s.signalMatrixData);
    sReversed.samplingRateData = s.samplingRateData;
    sReversed.channelCount = s.channelCount;
    sReversed.fileNameData = s.fileNameData;
    sReversed.bitDepthData = s.bitDepthData;

    fprintf('Audio successfully reversed.');
end