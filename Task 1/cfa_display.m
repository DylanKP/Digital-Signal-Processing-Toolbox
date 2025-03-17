function cfa_display(s, domain)
    n = size(s.signalMatrixData, 1);

    if domain == 'f'
        f = (0:floor(n/2)) * s.samplingRateData / n;

        y = fft(s.signalMatrixData);
        P2 = abs(y/n);
        P1 = P2(1:floor(n/2)+1);

        if n > 1
            P1(2:end-1) = 2 * P1(2:end-1);
        end

        figure;
        plot(f, 20*log10(P1));
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');
        title('Frequency Domain');
    else 
        t = (0:n-1) / s.samplingRateData;

        figure;
        plot(t, s.signalMatrixData);
        xlabel('Time (s)');
        ylabel('Amplitude');
        title('Time Domain');
    end
end