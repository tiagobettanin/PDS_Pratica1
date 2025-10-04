function y = vibrato(x, fs, fv, beta)
    % vibrato - Aplica efeito de vibrato a um sinal de áudio.
    %
    % Sintaxe:
    %   y = vibrato(x, fs, fv, beta)
    %
    % Entradas:
    %   x    - Vetor de áudio de entrada.
    %   fs   - Frequência de amostragem (Hz).
    %   fv   - Frequência do vibrato (Hz), tipicamente entre 5-7 Hz.
    %   beta - Profundidade do vibrato (em segundos), indica o desvio máximo.
    %
    % Saída:
    %   y    - Vetor de áudio com o efeito de vibrato.

    % Garante que o vetor de entrada seja uma linha
    x = x(:)';

    % Número de amostras
    N = length(x);
    
    % Vetor de tempo para o sinal
    t = (0:N-1) / fs;
    
    % LFO (Low Frequency Oscillator) para o vibrato
    lfo = beta * sin(2 * pi * fv * t);
    
    % Cria um novo vetor de tempo modulado
    t_modulado = t + lfo;
    
    % Vetor de índices original (para interpolação)
    indices_originais = 1:N;
    
    % Converte o tempo modulado para novos índices de amostragem
    indices_modulados = t_modulado * fs + 1;
    
    % Garante que os índices não saiam dos limites do vetor original
    indices_modulados(indices_modulados > N) = N;
    indices_modulados(indices_modulados < 1) = 1;
    
    % Usa interpolação linear para amostrar o sinal 'x' nos novos índices
    y = interp1(indices_originais, x, indices_modulados, 'linear');
end