function h = gera_h_multieco(ganho, atraso_s, num_ecos, fs)
    % gera_h_multieco - Cria uma RI de eco com múltiplas repetições.
    %
    % Sintaxe: h = gera_h_multieco(ganho, atraso_s, num_ecos, fs)
    %
    % Entradas:
    %   ganho    - Fator de ganho (0 < ganho < 1). Controla o decaimento.
    %   atraso_s - Atraso entre os ecos, em segundos.
    %   num_ecos - Número total de repetições do eco.
    %   fs       - Frequência de amostragem (Hz).
    %
    % Saída:
    %   h        - Vetor da resposta ao impulso.
    
    % Converte o atraso de segundos para amostras (D)
    D = round(atraso_s * fs);
    
    % Calcula o comprimento total necessário para a RI
    len_h = 1 + (num_ecos - 1) * D;
    h = zeros(1, len_h);
    
    % Gera os impulsos (deltas) com ganho decrescente
    for i = 0:(num_ecos - 1)
        idx = 1 + i * D;
        amplitude = ganho^i;
        h(idx) = amplitude;
    end
end