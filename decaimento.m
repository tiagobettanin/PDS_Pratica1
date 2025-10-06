function y = decaimento(x, fs, alpha)
    N = length(x);
    t = (0:N-1) / fs;
    
    % Envelope de decaimento exponencial
    envelope = exp(-alpha * t);
    
    % Aplica o envelope ao sinal de áudio
    y = x(:)' .* envelope;

end
