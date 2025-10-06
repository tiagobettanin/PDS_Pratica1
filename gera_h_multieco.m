function h = gera_h_multieco(ganho, atraso_s, num_ecos, fs)
    D = round(atraso_s * fs);
    
    % Calcula o comprimento total necessário para a RI
    len_h = 1 + (num_ecos - 1) * D;
    h = zeros(1, len_h);
    
    % Gera os impulsos com ganho decrescente
    for i = 0:(num_ecos - 1)
        idx = 1 + i * D;
        amplitude = ganho^i;
        h(idx) = amplitude;
    end

end
