function ss = cfa_equalise(s, b)
    % This function equalizes the audio signal
    % The function takes a struct s as input, which must contain the field signalMatrixData
    % The function also takes a vector b as input, which specifies the gain values for each band
    % The function returns a struct ss with the equalized audio signal
    % cfa_equalise(s, b)

    % Sets the center frequencies for each band
    centerFreqs = [16, 31.5, 63, 125, 250, 500, 1000, 2000, 4000, 8000, 16000];
    % Converts the gain values from dB to linear scale
    linearGain = 10.^(b/20);
    % Get the number of samples and channels in the signal
    [n, channels] = size(s.signalMatrixData);

    % Calculate the frequency axis
    f = (0:n-1) * s.samplingRateData / n;

    % Initialize the equalized signal matrix
    equalizedSignal = zeros(size(s.signalMatrixData));

    for ch = 1:channels
        % Compute the Fourier transform of the signal
        Y = fft(s.signalMatrixData(:, ch));
        
        % Initialize the gain vector
        gainVector = ones(size(Y));
        
        % Apply the gain values to the corresponding frequency bands
        for i = 1:length(centerFreqs)
            % Determine the frequency bounds for the band
            if i == 1
                lowBound = 0;
            else
                lowBound = (centerFreqs(i-1) + centerFreqs(i)) / 2;
            end

            if i == length(centerFreqs)
                highBound = s.samplingRateData / 2;
            else
                highBound = (centerFreqs(i) + centerFreqs(i+1)) / 2;
            end
            
            % Find the indices of the frequencies within the band
            indices = f >= lowBound & f < highBound;
            gainVector(indices) = linearGain(i);
        end
        
        % Apply the gain values to the negative frequencies
        gainVector((n/2+1):end) = flip(gainVector(2:n/2+1));
        
        Y_equalized = Y .* gainVector;
        
        equalizedSignal(:, ch) = real(ifft(Y_equalized));
    end

    % Create a struct to store the equalized signal
    ss = struct();
    ss.signalMatrixData = equalizedSignal;
    ss.samplingRateData = s.samplingRateData;
    ss.channelCount = s.channelCount;
    ss.bitDepthData = s.bitDepthData;
    ss.fileNameData = s.fileNameData;
    disp('Signal equalised successfully');
end