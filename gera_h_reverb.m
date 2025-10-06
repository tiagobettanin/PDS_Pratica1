function h = gera_h_reverb(alpha, N, fs)
    % gera_h_reverb - Cria uma RI de reverb curto com ruído.
    %
    % Sintaxe: h = gera_h_reverb(alpha, N, fs)
    %
    % Entradas:
    %   alpha - Coeficiente de decaimento. Controla a "cauda" do reverb.
    %   N     - Duração da RI em número de amostras.
    %   fs    - Frequência de amostragem (Hz).
    %
    % Saída:
    %   h     - Vetor da resposta ao impulso.

    % Vetor de tempo discreto (n) e contínuo (t)
    n = 0:N-1;
    t = n / fs;
    
    % Gera o ruído branco w[n]
    w = randn(1, N);
    
    % Gera a RI conforme a fórmula h[n] = exp(-alpha*t) * w[n]
    h = exp(-alpha * t) .* w;
    
    % Normaliza a RI para um pico de 1
    h = h / max(abs(h));
end