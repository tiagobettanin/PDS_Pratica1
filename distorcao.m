function y = distorcao(x, L)
    % distorcao - Aplica distorção por clipping simétrico.
    %
    % Sintaxe:
    %   y = distorcao(x, L)
    %
    % Entradas:
    %   x - Vetor de áudio de entrada.
    %   L - Limiar (threshold) de clipping (0 < L <= 1). Valores menores
    %       causam mais distorção.
    %
    % Saída:
    %   y - Vetor de áudio distorcido.

    % Garante que L seja positivo
    if L <= 0
        error('O limiar L deve ser um valor positivo.');
    end
    
    % Aplica o clipping:
    % 1. Encontra todos os valores acima de L e os define como L.
    % 2. Encontra todos os valores abaixo de -L e os define como -L.
    y = max(min(x, L), -L);
end