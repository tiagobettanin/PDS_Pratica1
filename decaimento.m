function y = decaimento(x, fs, alpha)
    % decaimento - Aplica um envelope de decaimento exponencial a um sinal.
    %
    % Sintaxe:
    %   y = decaimento(x, fs, alpha)
    %
    % Entradas:
    %   x     - Vetor de áudio de entrada.
    %   fs    - Frequência de amostragem (Hz).
    %   alpha - Coeficiente de decaimento. Valores maiores resultam em
    %           decaimento mais rápido. Um valor de 5 é um bom começo.
    %
    % Saída:
    %   y     - Vetor de áudio com o envelope de decaimento.
    
    % Número de amostras
    N = length(x);
    
    % Vetor de tempo
    t = (0:N-1) / fs;
    
    % Envelope de decaimento exponencial
    envelope = exp(-alpha * t);
    
    % Aplica o envelope ao sinal de áudio
    y = x(:)' .* envelope;
end