function x = geraNota(f0, fs, duracao, tipo)
    t = 0:1/fs:duracao;

    switch lower(tipo)
        case 'seno'
            x = sin(2*pi*f0*t);
            
        case 'quadrada'
            % Quadrada: +1 para meia onda positiva, -1 para meia onda negativa
            x = sign(sin(2*pi*f0*t));
            % x = (sign(sin(2*pi*f0*t))+1)/2;
            
        case 'serra'
            % Onda serra sobe linearmente de -1 até +1 em cada período
            frac = mod(f0*t,1);     
            x = 2*frac - 1;    
            
        case 'triangular'
            % Onda triangular é linear entre -1 e +1
            frac = mod(f0*t,1);     
            x = 2*abs(2*frac - 1) - 1; 
            
        case 'ruido'
            x = randn(size(t));     
            
        otherwise
            error('Tipo de onda não reconhecido. Use: seno, quadrada, serra, triangular, ruido');
    end
end
