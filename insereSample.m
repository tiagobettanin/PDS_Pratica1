function musica = insereSample(musica, sample, t0, fs)
    inicio = round(t0 * fs) + 1;
    fim = inicio + length(sample) - 1;
    
    % Se necessário, aumenta o tamanho do vetor 'musica'
    if fim > length(musica)
        musica(end+1:fim) = 0; % completa com zeros
    end
    
    musica(inicio:fim) = musica(inicio:fim) + sample(:)'; 
end
