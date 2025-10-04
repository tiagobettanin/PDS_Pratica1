function y = eco(x, fs, atraso, ganho)
    % eco - Adiciona um eco simples (single-tap delay) a um sinal de áudio.
    %
    % Sintaxe:
    %   y = eco(x, fs, atraso, ganho)
    %
    % Entradas:
    %   x      - Vetor de áudio de entrada.
    %   fs     - Frequência de amostragem (Hz).
    %   atraso - Tempo de atraso do eco em segundos. 
    %   ganho  - Ganho do eco (amplitude), tipicamente entre 0 e 1.
    %
    % Saída:
    %   y      - Vetor de áudio com eco.

    % Converte o atraso de segundos para número de amostras
    delay_amostras = round(atraso * fs);
    
    % Cria um vetor de zeros com o tamanho do delay
    zeros_delay = zeros(1, delay_amostras);
    
    % Cria a versão atrasada do sinal
    x_atrasado = [zeros_delay, x(:)'];
    
    % Alinha o sinal original com o atrasado, preenchendo com zeros
    x_original = [x(:)', zeros_delay];
    
    % Soma o sinal original com a versão atrasada e com ganho
    y = x_original + ganho * x_atrasado;
end