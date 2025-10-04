function musica = insereSample(musica, sample, t0, fs)
    % insereSample - Insere um sample de áudio dentro de um vetor música
    %
    % Sintaxe:
    %   musica = insereSample(musica, sample, t0, fs)
    %
    % Entradas:
    %   musica - vetor contendo a música (áudio principal)
    %   sample - vetor contendo o áudio a ser inserido
    %   t0     - instante de inserção em segundos
    %   fs     - frequência de amostragem (Hz)
    %
    % Saída:
    %   musica - vetor de áudio com o sample inserido
    
    % Calcula o índice de início
    inicio = round(t0 * fs) + 1;
    fim = inicio + length(sample) - 1;
    
    % Se necessário, aumenta o tamanho do vetor 'musica'
    if fim > length(musica)
        musica(end+1:fim) = 0; % completa com zeros
    end
    
    % Insere o sample somando no intervalo correspondente
    musica(inicio:fim) = musica(inicio:fim) + sample(:)'; 
end