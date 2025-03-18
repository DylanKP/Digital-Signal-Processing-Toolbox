function cfa_play(s,v)
    % This function plays the audio signal
    % The function takes a struct s as input, which must contain the fields signalMatrixData and samplingRateData
    % The function also takes an optional argument v, which specifies the volume level (default is 100)
    % cfa_play(s, v)

    % Check if the volume level is provided
    if nargin < 2
        v = 100;
    end
    % Check if the input is a struct with the required fields
    if ~isstruct(s) || ~isfield(s, 'signalMatrixData') || ~isfield(s, 'samplingRateData')
        error('Input must be a struct with fields signalMatrixData and samplingRateData');
    end

    % Check if the volume level is within the valid range
    if v < 0 || v > 100
        error('Volume level must be between 0 and 100');
    end

    % Play the audio signal at the specified volume level
    volume = s.signalMatrixData * (v/100);
    sound(volume, s.samplingRateData);
    disp('Playing audio...');
end