function cfa_display(s, domain)
    % This function displays the input signal in the specified domain.
    % It works by plotting the signal in the time domain or frequency domain based on the input argument.
    % The function takes a struct s as input, which must contain the fields signalMatrixData and samplingRateData.
    % The function also takes an optional argument domain, which specifies the domain to display the signal in ('t' for time domain, 'f' for frequency domain).
    % If domain is not provided, the default is 't' for time domain.
    % cfa_display(s, domain)

    % Check if the input is a struct with the required fields
    if ~isstruct(s) || ~isfield(s, 'signalMatrixData') || ~isfield(s, 'samplingRateData')
        error('Input must be a struct with fields signalMatrixData and samplingRateData');
    end

    % Check if the domain argument is provided
    if nargin < 2 || isempty(domain)
        domain = 't';
    end

    n = size(s.signalMatrixData, 1);

    % Calculate the frequency axis for the frequency domain plot
    if domain == 'f'
        % Calculate the frequency axis
        f = (0:floor(n/2)) * s.samplingRateData / n;

        % Compute the Fourier transform of the signal
        y = fft(s.signalMatrixData);
        P2 = abs(y/n);
        P1 = P2(1:floor(n/2)+1);

        % Multiply by 2 to account for the negative frequencies
        if n > 1
            P1(2:end-1) = 2 * P1(2:end-1);
        end

        % Plot the frequency domain
        figure;
        plot(f, 20*log10(P1));
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');
        title('Frequency Domain');
    else 
        % Calculate the time axis for the time domain plot
        t = (0:n-1) / s.samplingRateData;

        % Plot the time domain
        figure;
        plot(t, s.signalMatrixData);
        xlabel('Time (s)');
        ylabel('Amplitude');
        title('Time Domain');
    end
end