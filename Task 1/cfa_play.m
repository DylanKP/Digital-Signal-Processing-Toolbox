function cfa_play(s,v)
    volume = s.signalMatrixData * (v/100);
    sound(volume, s.samplingRateData);
    disp('Playing audio...');
end