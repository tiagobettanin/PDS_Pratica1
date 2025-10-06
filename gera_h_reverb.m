function h = gera_h_reverb(alpha, N, fs)
    % Vetor de tempo discreto (n) e contínuo (t)
    n = 0:N-1;
    t = n / fs;
    
    % Gera o ruído branco w[n]
    w = randn(1, N);
    
    % Gera a RI conforme a fórmula h[n] = exp(-alpha*t) * w[n]
    h = exp(-alpha * t) .* w;
    
    % Normaliza para um pico de 1
    h = h / max(abs(h));

end
