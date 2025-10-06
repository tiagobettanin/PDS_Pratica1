function y = eco(x, fs, atraso, ganho)
    % Cria a versão atrasada do sinal
    delay_amostras = round(atraso * fs);
    zeros_delay = zeros(1, delay_amostras);
    x_atrasado = [zeros_delay, x(:)'];
    
    % Alinha o sinal original com o atrasado, preenchendo com zeros
    x_original = [x(:)', zeros_delay];
    
    % Soma o sinal original com a versão atrasada e com ganho
    y = x_original + ganho * x_atrasado;

end
