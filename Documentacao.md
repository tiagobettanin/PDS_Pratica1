# Documentação - Projeto de Processamento Digital de Sinais de Áudio

Este documento detalha o funcionamento de um conjunto de funções e scripts em MATLAB desenvolvidos para a manipulação de sons. As funções permitem aplicar efeitos sonoros clássicos e construir sequências musicais.

## Tabela de Parâmetros Sugeridos

A tabela a seguir fornece faixas de valores recomendadas para os parâmetros dos efeitos, servindo como um bom ponto de partida para a exploração sonora.

| Efeito | Parâmetros | Valores Sugeridos | Notas |
| :--- | :--- | :--- | :--- |
| **Vibrato** | `fv` (Hz), `beta` (s) | `5-7`, `0.002-0.005` | Controla a oscilação no tom |
| **Tremolo** | `fm` (Hz), `m` | `4-8`, `0.3-0.7` | Controla a oscilação no volume |
| **Decaimento**| `alpha` | `3-7` | Controla a "morte" do som |
| **Distorção**| `L` | `0.1-0.5` | Quanto menor, mais agressivo |
| **Eco** | `atraso` (s), `ganho` | `0.2-0.5`, `0.4-0.7` | Atraso e volume das repetições |

-----

## Documentação Detalhada das Funções e Scripts

### 1\. `insereSample.m`

**Finalidade:**
Insere (soma) um trecho de áudio (`sample`) dentro de um vetor de áudio maior (`musica`) em uma posição de tempo específica.

**Sintaxe:**

```matlab
musica = insereSample(musica, sample, t0, fs)
```

**Entradas (Parâmetros):**

  * `musica` (vetor): O vetor de áudio principal onde o sample será inserido.
  * `sample` (vetor): O trecho de áudio a ser inserido.
  * `t0` (double): O instante de tempo (em segundos) onde o `sample` deve começar a ser inserido.
  * `fs` (double): A frequência de amostragem em Hz.

**Saída:**

  * `musica` (vetor): O vetor de áudio original com o novo sample somado na posição correta. O vetor pode ser estendido se o sample ultrapassar seu tamanho original.

**Exemplo de Uso:**

```matlab
fs = 44100;
musica = zeros(1, fs * 3); % Trilha de 3 segundos de silêncio
nota_do = geraNota(261.63, fs, 1, 'seno'); % Supondo que geraNota exista
% Insere a nota Dó no segundo 1.5 da trilha.
musica = insereSample(musica, nota_do, 1.5, fs);
sound(musica, fs);
```

-----

### 2\. `vibrato.m`

**Finalidade:**
Aplica um efeito de vibrato, que é uma modulação sutil e periódica na frequência (tom) do som.

**Sintaxe:**

```matlab
y = vibrato(x, fs, fv, beta)
```

**Entradas (Parâmetros):**

  * `x` (vetor): O sinal de áudio de entrada.
  * `fs` (double): A frequência de amostragem em Hz.
  * `fv` (double): A frequência do vibrato em Hz. Controla a **velocidade** da oscilação do tom.
  * `beta` (double): A profundidade do vibrato em segundos. Controla a **intensidade** da variação do tom.

**Saída:**

  * `y` (vetor): O sinal de áudio com o efeito de vibrato aplicado.

**Exemplo de Uso:**

```matlab
fs = 44100;
% Supondo que exista uma nota ou áudio na variável 'nota'
nota_vibrato = vibrato(nota, fs, 6, 0.003);
sound(nota_vibrato, fs);
```

-----

### 3\. `tremolo.m`

**Finalidade:**
Aplica um efeito de tremolo, que é uma modulação periódica na amplitude (volume) do som.

**Sintaxe:**

```matlab
y = tremolo(x, fs, fm, m)
```

**Entradas (Parâmetros):**

  * `x` (vetor): O sinal de áudio de entrada.
  * `fs` (double): A frequência de amostragem em Hz.
  * `fm` (double): A frequência do tremolo em Hz. Controla a **velocidade** da variação de volume.
  * `m` (double): A profundidade (índice) da modulação, entre `0` e `1`. Controla a **intensidade** da variação de volume.

**Saída:**

  * `y` (vetor): O sinal de áudio com o efeito de tremolo aplicado.

**Exemplo de Uso:**

```matlab
fs = 44100;
% Supondo que exista um áudio na variável 'acorde'
acorde_tremolo = tremolo(acorde, fs, 7, 0.7);
sound(acorde_tremolo / max(abs(acorde_tremolo)), fs);
```

-----

### 4\. `decaimento.m`

**Finalidade:**
Aplica um envelope de decaimento exponencial sobre o som, fazendo com que seu volume diminua suavemente ao longo do tempo.

**Sintaxe:**

```matlab
y = decaimento(x, fs, alpha)
```

**Entradas (Parâmetros):**

  * `x` (vetor): O sinal de áudio de entrada.
  * `fs` (double): A frequência de amostragem em Hz.
  * `alpha` (double): O coeficiente de decaimento. Valores maiores fazem o som decair mais rápido.

**Saída:**

  * `y` (vetor): O sinal de áudio com o decaimento aplicado.

**Exemplo de Uso:**

```matlab
fs = 44100;
% Supondo que exista um áudio na variável 'nota'
nota_decaimento = decaimento(nota, fs, 5);
sound(nota_decaimento, fs);
```

-----

### 5\. `distorcao.m`

**Finalidade:**
Aplica uma distorção de *clipping*, que "achata" a onda sonora quando ela ultrapassa um certo limiar de amplitude, resultando em um som mais agressivo e ruidoso.

**Sintaxe:**

```matlab
y = distorcao(x, L)
```

**Entradas (Parâmetros):**

  * `x` (vetor): O sinal de áudio de entrada.
  * `L` (double): O limiar (threshold) de clipping, um valor positivo entre `0` e `1`. Valores menores causam mais distorção.

**Saída:**

  * `y` (vetor): O sinal de áudio distorcido.

**Exemplo de Uso:**

```matlab
fs = 44100;
% Supondo que exista um áudio na variável 'nota'
nota_distorcida = distorcao(nota, 0.1);
sound(nota_distorcida, fs);
```

-----

### 6\. `eco.m` (Versão com Feedback)

**Finalidade:**
Adiciona um eco com múltiplas repetições que decaem em volume ao longo do tempo. Esta versão é mais realista que um eco simples, pois o som é realimentado (*feedback*), criando uma cauda de ecos.

**Sintaxe:**

```matlab
y = eco(x, fs, atraso, ganho)
```

**Entradas (Parâmetros):**

  * `x` (vetor): O sinal de áudio de entrada.
  * `fs` (double): A frequência de amostragem em Hz.
  * `atraso` (double): O tempo em segundos entre cada repetição do eco.
  * `ganho` (double): O fator de realimentação, entre `0` e `1`. Controla o quão rápido as repetições perdem volume. Um ganho maior resulta em uma cauda de eco mais longa.

**Saída:**

  * `y` (vetor): O sinal de áudio com as múltiplas repetições de eco.

**Exemplo de Uso:**

```matlab
fs = 44100;
% Supondo que um áudio curto exista na variável 'nota_curta'
som_com_eco = eco(nota_curta, fs, 0.25, 0.6);
sound(som_com_eco, fs);
```

-----

### 7\. `main.m` (Script Principal)

**Finalidade:**
Este é o script principal executável, projetado para demonstrar todas as funcionalidades exigidas na atividade prática, seguindo uma ordem lógica de apresentação: da geração de elementos básicos até a composição final.

**Operação:**
O script executa uma sequência de 5 passos para demonstrar todos os conceitos:

1.  **Demonstração de Notas Simples em Diferentes Formas de Onda:**

      * Primeiramente, gera e reproduz a mesma nota musical (`Lá`) com as quatro formas de onda principais (senoidal, quadrada, serra, triangular) para comparação de timbre.
      * Exibe um gráfico com a forma de onda de cada uma.

2.  **Formação de Acordes pela SOMA de Notas:**

      * Demonstra a maneira correta de se criar um acorde, que consiste na **soma** dos vetores de áudio de cada nota individual.
      * Cria e reproduz um acorde de Dó Maior como exemplo.

3.  **Aplicação de Cada Efeito Separadamente:**

      * Testa, de forma individual, cada uma das cinco funções de efeito (`vibrato`, `tremolo`, `decaimento`, `distorcao` e `eco`).
      * Para cada efeito, o som original é tocado, seguido pelo som com o efeito aplicado.

4.  **Demonstração da Inserção de Samples:**

      * Apresenta um exemplo simples e claro do uso da função `insereSample`, posicionando duas notas em uma trilha de silêncio para formar uma pequena sequência.

5.  **Reprodução da Música Final:**

      * A etapa final integra todos os conceitos anteriores para construir e tocar uma música completa.
      * **Harmonia:** Cria uma base com uma progressão de quatro acordes (C → G → Am → F).
      * **Melodia:** Cria uma linha melódica com notas individuais sobre a harmonia.
      * **Efeitos:** Aplica `vibrato` na melodia e `tremolo` na harmonia.
      * **Mixagem:** Soma as trilhas de harmonia e melodia, normaliza o volume e reproduz o resultado final.

**Como Usar:**
Basta abrir o arquivo `main.m` no MATLAB e clicar em "Run". Certifique-se de que todas as outras funções (`.m`) estejam na mesma pasta ou no *path* do MATLAB.