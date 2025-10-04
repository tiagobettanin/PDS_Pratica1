# PDS_Pratica1

# Divisão de tarefas (3 pessoas)

## Pessoa 1 — Geradores + acordes + samples
**Objetivo:** garantir que existam sinais base sólidos e reproduzíveis.

### Tarefas
- Implementar **`geraNota(f0, fs, duracao, tipo)`** (seno, quadrada, serra, triangular, ruido).
- Criar e testar **formação de acordes** por soma de notas:
  - C (261.63, 329.63, 392.00), Am (440, 261.63, 329.63) etc.
- Implementar `insereSample(musica, sample, t0, fs)`.
- Script de testes: tocar Lá (440), Dó (261.63), Mi (329.63) em todas as ondas; tocar acordes; inserir samples em posições distintas.
- **Plots** curtos (zoom) dos sinais gerados (antes de efeitos).

### Entregáveis
- `geraNota.m`
- `insereSample.m`
- `teste_geraNota_e_acordes.m` (gera áudio, toca com `sound`, e plota trechos).
- Pequenos clipes `.wav` de cada forma de onda e de 2 acordes (para referência).

---

## Pessoa 2 — Efeitos paramétricos (Parte 4.3) + validação
**Objetivo:** aplicar e demonstrar os efeitos clássicos de modulação e dinâmica.

### Tarefas
- Implementar e testar:
  - `vibrato(x, fs, fv, beta)`
  - `tremolo(x, fs, fm, m)`
  - `decaimento(x, fs, alpha)`
  - `distorcao(x, L)` (clipping simétrico)
  - `eco(x, fs, atraso, ganho)` (delay simples 1-tap)
- Criar **exemplos isolados** aplicando os efeitos sobre as notas e acordes da Pessoa 1.
- Garantir **normalização segura** (evitar clipping não-intencional nos exemplos).
- **Comparar timbres** por forma de onda + efeito (curtos áudios A/B e plots do envelope/modulação).

### Entregáveis
- `vibrato.m`, `tremolo.m`, `decaimento.m`, `distorcao.m`, `eco.m`
- `teste_efeitos.m` (aplica efeito por vez em sinais da Pessoa 1 + plots de 100–200 ms)
- 1 tabela/trecho no script com **parâmetros sugeridos** (ex.: vibrato `fv=5–7 Hz`, `beta=~0.05–0.1 rad`; tremolo `fm=4–8 Hz`, `m=0.3–0.7`; etc.)

---

## Pessoa 3 — Convolução (Parte 6) + composição/integrador
**Objetivo:** entregar a parte de filtros por convolução e costurar tudo numa música final.

### Tarefas
- **Parte 6.1 – Filtros clássicos por convolução**
  - Gerar IR de **reverb curto com ruído**: `h_rev[n] = exp(-alpha*n).*w[n]`, tamanho N.
  - Gerar IR de **multi-eco**: `h_delay[n] = δ[n] + g δ[n-D] + g^2 δ[n-2D] + ...`
  - Aplicar `conv` / `conv(...,'same')` em:
    - (1) melodia criada na Parte 1,
    - (2) `guitar.wav`,
    - (3) `voz.wav`.
  - Plots comparando original × com efeito; comentar influência de `alpha`, `N`, `g`, `D`.
- **Parte 6.2 – Efeitos experimentais**
  - Preparar 3 IRs gravadas (normalizar |h|≤1), documentar origem (palma, estalo, lata/tubo etc.).
  - Aplicar nas mesmas três fontes (melodia, guitarra, voz).
- **Composição final (Parte 4.5)**
  - Montar **progressão**: C → G → Am → F (1 s por acorde) como **harmonia**.
  - Construir **melodia** sugerida (0.5 s cada) e **inserir com `insereSample`**.
  - **Automação de efeitos**: ex. vibrato na melodia, tremolo leve na harmonia, eco no fim de cada compasso, reverb curto global.
  - Mixagem simples: normalizar, evitar clipping, fade-in/out breve.
- Integrar tudo no **script principal**.

### Entregáveis
- `geraIR_reverbCurto.m`, `geraIR_multiecos.m`, `aplicaConvolucao.m`
- `teste_convolucao.m` (com gráficos e comentários)
- **Gravações**/arquivos das 3 IRs experimentais (ex.: `IR_palmas.wav`, `IR_lata.wav`, `IR_chocalho.wav`)
- `main_projeto.m` (roda exemplos das Partes 4 e 6 e toca a música final)