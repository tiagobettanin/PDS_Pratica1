function y = vibrato(x, fs, fv, beta)
    x = x(:)';
    N = length(x);
    
    t = (0:N-1) / fs;
    
    % LFO (Low Frequency Oscillator) para o vibrato
    lfo = beta * sin(2 * pi * fv * t);
    
    t_modulado = t + lfo;
    
    indices_originais = 1:N;
    
    indices_modulados = t_modulado * fs + 1;
    
    indices_modulados(indices_modulados > N) = N;
    indices_modulados(indices_modulados < 1) = 1;
    
    y = interp1(indices_originais, x, indices_modulados, 'linear');

end
