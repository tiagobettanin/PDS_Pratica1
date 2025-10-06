function y = distorcao(x, L)
    if L <= 0
        error('O limiar L deve ser um valor positivo.');
    end
    
    % Aplica o clipping:
    % 1. Encontra todos os valores acima de L e os define como L.
    % 2. Encontra todos os valores abaixo de -L e os define como -L.
    y = max(min(x, L), -L);

end
