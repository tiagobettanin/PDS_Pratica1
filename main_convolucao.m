% Script Principal da Atividade Prática 1 - PARTE 6: EFEITOS POR CONVOLUÇÃO

clear all;
close all;
clc;

% --- Parâmetros Globais ---
fs = 44100;

%% --- 1. GERAÇÃO DAS FONTES DE ÁUDIO ---
fprintf('--- 1. Gerando/Carregando fontes de áudio para os testes ---\n');

% Fonte 1: Melodia Sintética
x_melodia = zeros(1, 2*fs);
melodia_notas = [261.63, 293.66, 329.63, 349.23]; % C, D, E, F
for i = 1:4
    nota = geraNota(melodia_notas(i), fs, 0.4, 'quadrada');
    x_melodia = insereSample(x_melodia, nota * 0.4, (i-1)*0.5, fs);
end
disp('Tocando melodia sintética...'); sound(x_melodia, fs); pause(length(x_melodia)/fs + 0.5);

% Fontes 2 e 3: Carregando arquivos .wav (coloque-os na mesma pasta)
% Se os arquivos não existirem, o script irá gerar simulações
try
    [x_guitarra, fs_g] = audioread('guitar.wav');
    if fs_g ~= fs, x_guitarra = resample(x_guitarra, fs, fs_g); end
    x_guitarra = x_guitarra(:,1)'; % Garante que seja mono e vetor linha
    x_guitarra = x_guitarra / max(abs(x_guitarra));
    disp('Arquivo guitar.wav carregado.');
catch
    disp('Arquivo guitar.wav não encontrado. Gerando simulação...');
    t_guitar = 0:1/fs:1.5;
    x_guitarra = (geraNota(110, fs, 1.5, 'serra') + geraNota(220, fs, 1.5, 'serra')) .* exp(-2.5*t_guitar);
    x_guitarra = x_guitarra / max(abs(x_guitarra));
end
disp('Tocando guitarra...'); sound(x_guitarra, fs); pause(length(x_guitarra)/fs + 0.5);

try
    [x_voz, fs_v] = audioread('voz.wav');
    if fs_v ~= fs, x_voz = resample(x_voz, fs, fs_v); end
    x_voz = x_voz(:,1)'; % Garante que seja mono e vetor linha
    x_voz = x_voz / max(abs(x_voz));
    disp('Arquivo voz.wav carregado.');
catch
    disp('Arquivo voz.wav não encontrado. Gerando simulação...');
    t_voz = 0:1/fs:2;
    vogal = geraNota(150,fs,2,'seno') + 0.6*geraNota(300,fs,2,'seno') + 0.4*geraNota(450,fs,2,'seno');
    x_voz = vibrato(vogal, fs, 6, 0.003);
    x_voz = x_voz / max(abs(x_voz));
end
disp('Tocando voz...'); sound(x_voz, fs); pause(length(x_voz)/fs + 0.5);


%% --- 2. GERAÇÃO DAS RESPOSTAS AO IMPULSO (h[n]) ---
fprintf('\n--- 2. Gerando as Respostas ao Impulso (Filtros) ---\n');

% Parte 6.1: Filtros Clássicos
h_reverb = gera_h_reverb(5, fs * 0.5, fs);
h_eco = gera_h_multieco(0.5, 0.25, 5, fs); 

% Parte 6.2: Filtros Experimentais (carregue seus .wav aqui)
try
    [h_palma, fs_p] = audioread('palma.wav');
    if fs_p ~= fs, h_palma = resample(h_palma, fs, fs_p); end
    h_palma = h_palma(:,1)'; h_palma = h_palma / max(abs(h_palma));
    disp('IR experimental "palma.wav" carregada.');
catch
    disp('IR "palma.wav" não encontrada. Gerando simulação...');
    t_exp = 0:1/fs:0.5;
    h_palma = randn(size(t_exp)) .* exp(-30*t_exp);
    h_palma = h_palma / max(abs(h_palma));
end

% Adicione aqui o carregamento dos seus outros dois áudios experimentais
% (metal.wav, madeira.wav), ou use as simulações abaixo:

% Simulação de 'metal.wav'
t_exp = 0:1/fs:0.8;
h_metal = (sin(2*pi*2500*t_exp) + sin(2*pi*4100*t_exp)) .* exp(-10*t_exp);
h_metal = h_metal / max(abs(h_metal));

% Simulação de 'madeira.wav'
t_exp = 0:1/fs:0.3;
h_madeira = sin(2*pi*300*t_exp) .* exp(-50*t_exp);
h_madeira = h_madeira / max(abs(h_madeira));

disp('Respostas ao impulso geradas/carregadas. Pressione uma tecla para iniciar a convolução...');
pause;

%% --- 3. APLICAÇÃO E TESTE DOS EFEITOS POR CONVOLUÇÃO ---
fprintf('\n--- 3. Aplicando filtros e tocando resultados ---\n');

fontes = {x_melodia, x_guitarra, x_voz};
nomes_fontes = {'Melodia Sintética', 'Guitarra', 'Voz'};
filtros = {h_reverb, h_eco, h_palma, h_metal, h_madeira};
nomes_filtros = {'Reverb Curto', 'Multi-Eco', 'Palma (Exp)', 'Metal (Exp)', 'Madeira (Exp)'};

for i = 1:length(fontes)
    for j = 1:length(filtros)
        x = fontes{i};
        h = filtros{j};
        titulo = sprintf('Fonte: %s | Efeito: %s', nomes_fontes{i}, nomes_filtros{j});
        fprintf('\n--- %s ---\n', titulo);
        
        y = conv(x, h, 'same');
        y = y / max(abs(y));
        
        disp('Tocando original...'); sound(x, fs); pause(length(x)/fs + 0.3);
        disp('Tocando com efeito de convolução...'); sound(y, fs); pause(length(y)/fs + 0.3);
        
        figure('Name', titulo);
        t_plot = (0:length(x)-1)/fs;
        subplot(2,1,1); plot(t_plot, x); title('Sinal Original'); grid on;
        subplot(2,1,2); plot(t_plot, y); title('Sinal com Efeito'); grid on;
    end
end
fprintf('\n--- FIM DO SCRIPT DA PARTE 6 ---\n');