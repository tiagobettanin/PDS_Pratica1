% Script Principal da Atividade Prática 1 - PDS
% Demonstra todos os requisitos do projeto na ordem especificada.

clear all;
close all;
clc;

% --- Parâmetros Globais ---
fs = 44100; % Frequência de amostragem padrão

%% 1. Demonstração de Notas Simples em Diferentes Formas de Onda
fprintf('--- 1. Gerando Notas com Diferentes Formas de Onda ---\n');
dur = 1; % Duração de 1 segundo
f0 = 440; % Frequência da nota Lá (A4)

% Gera as notas
nota_seno = geraNota(f0, fs, dur, 'seno');
nota_quad = geraNota(f0, fs, dur, 'quadrada');
nota_serra = geraNota(f0, fs, dur, 'serra');
nota_tri = geraNota(f0, fs, dur, 'triangular');

% Toca cada nota para comparação auditiva
disp('Tocando onda Senoidal...'); sound(nota_seno, fs);
pause(length(nota_seno)/fs + 0.2); 

disp('Tocando onda Quadrada...'); sound(nota_quad, fs);
pause(length(nota_quad)/fs + 0.2);

disp('Tocando onda Serra...'); sound(nota_serra, fs);
pause(length(nota_serra)/fs + 0.2);

disp('Tocando onda Triangular...'); sound(nota_tri, fs);
pause(length(nota_tri)/fs + 0.2);

% Plota as formas de onda para comparação visual
figure('Name', '1. Formas de Onda');
subplot(4,1,1); plot(nota_seno(1:500)); title('Onda Senoidal');
subplot(4,1,2); plot(nota_quad(1:500)); title('Onda Quadrada');
subplot(4,1,3); plot(nota_serra(1:500)); title('Onda Serra');
subplot(4,1,4); plot(nota_tri(1:500)); title('Onda Triangular');
fprintf('Seção 1 concluída.\n\n');


%% 2. Demonstração da Formação de Acordes pela SOMA de Notas
fprintf('--- 2. Formando Acordes por SOMA ---\n');
dur_acorde = 2; % Duração de 2 segundos para o acorde

% Frequências para o acorde de Dó Maior (C, E, G)
f_do = 261.63;
f_mi = 329.63;
f_sol = 392.00;

% Gera cada nota do acorde separadamente
nota_do = geraNota(f_do, fs, dur_acorde, 'seno');
nota_mi = geraNota(f_mi, fs, dur_acorde, 'seno');
nota_sol = geraNota(f_sol, fs, dur_acorde, 'seno');

% Cria o acorde SOMANDO as notas
acorde_do_maior = nota_do + nota_mi + nota_sol;

% Normaliza o acorde para evitar clipping
acorde_do_maior = acorde_do_maior / max(abs(acorde_do_maior));
disp('Tocando o acorde de Dó Maior (formado por soma)...');
sound(acorde_do_maior, fs);
pause(length(acorde_do_maior)/fs + 0.2);
fprintf('Seção 2 concluída.\n\n');


%% 3. Demonstração da Aplicação de Cada Efeito Separadamente
fprintf('--- 3. Demonstrando Efeitos Sonoros Individuais ---\n');
dur_efeito = 1.5;
nota_base = geraNota(f0, fs, dur_efeito, 'seno');
nota_base = nota_base / max(abs(nota_base));
acorde_base_efeito = acorde_do_maior;

% --- Teste do Vibrato ---
fprintf('\n- Testando Vibrato...\n');
nota_vibrato = vibrato(nota_base, fs, 6, 0.003);
disp('  Original...'); sound(nota_base, fs); pause(length(nota_base)/fs + 0.3);
disp('  Com Vibrato...'); sound(nota_vibrato, fs); pause(length(nota_vibrato)/fs);

% Plot do Vibrato
figure('Name', 'Efeito: Vibrato');
t_efeito = (0:length(nota_base)-1) / fs;
plot_samples = round(0.150 * fs);
plot(t_efeito(1:plot_samples), nota_base(1:plot_samples), 'b-', 'DisplayName', 'Original'); hold on;
plot(t_efeito(1:plot_samples), nota_vibrato(1:plot_samples), 'r--', 'DisplayName', 'Com Vibrato');
title('Comparação: Vibrato'); xlabel('Tempo (s)'); ylabel('Amplitude'); legend; grid on;

% --- Teste do Tremolo ---
fprintf('\n- Testando Tremolo...\n');
nota_tremolo = tremolo(nota_base, fs, 7, 0.6);
disp('  Original...'); sound(nota_base, fs); pause(length(nota_base)/fs + 0.3);
disp('  Com Tremolo...'); sound(nota_tremolo, fs); pause(length(nota_tremolo)/fs);

% Plot do Tremolo
figure('Name', 'Efeito: Tremolo');
plot(t_efeito(1:plot_samples), nota_base(1:plot_samples), 'b-', 'DisplayName', 'Original'); hold on;
plot(t_efeito(1:plot_samples), nota_tremolo(1:plot_samples), 'r--', 'DisplayName', 'Com Tremolo');
title('Comparação: Tremolo'); xlabel('Tempo (s)'); ylabel('Amplitude'); legend; grid on;

% --- Teste do Decaimento ---
fprintf('\n- Testando Decaimento...\n');
acorde_decay = decaimento(acorde_base_efeito, fs, 3);
disp('  Original...'); sound(acorde_base_efeito, fs); pause(length(acorde_base_efeito)/fs + 0.3);
disp('  Com Decaimento...'); sound(acorde_decay, fs); pause(length(acorde_decay)/fs);

% Plot do Decaimento
figure('Name', 'Efeito: Decaimento');
t_acorde_efeito = (0:length(acorde_base_efeito)-1) / fs;
plot(t_acorde_efeito, acorde_base_efeito, 'b-', 'DisplayName', 'Original'); hold on;
plot(t_acorde_efeito, acorde_decay, 'r--', 'DisplayName', 'Com Decaimento');
title('Comparação: Decaimento'); xlabel('Tempo (s)'); ylabel('Amplitude'); legend; grid on;

% --- Teste da Distorção ---
fprintf('\n- Testando Distorção...\n');
nota_dist = distorcao(nota_base, 0.2);
disp('  Original...'); sound(nota_base, fs); pause(length(nota_base)/fs + 0.3);
disp('  Com Distorção...'); sound(nota_dist, fs); pause(length(nota_dist)/fs);

% Plot da Distorção
figure('Name', 'Efeito: Distorção');
L = 0.2;
plot(t_efeito(1:plot_samples), nota_base(1:plot_samples), 'b-', 'DisplayName', 'Original'); hold on;
plot(t_efeito(1:plot_samples), nota_dist(1:plot_samples), 'r--', 'DisplayName', 'Com Distorção');
line([0, t_efeito(plot_samples)], [L, L], 'Color', 'k', 'LineStyle', ':', 'DisplayName', 'Limiar L');
line([0, t_efeito(plot_samples)], [-L, -L], 'Color', 'k', 'LineStyle', ':');
title('Comparação: Distorção'); xlabel('Tempo (s)'); ylabel('Amplitude'); legend; grid on;

% --- Teste do Eco ---
fprintf('\n- Testando Eco...\n');
nota_eco = eco(nota_base, fs, 0.3, 0.6);
disp('  Original...'); sound(nota_base, fs); pause(length(nota_base)/fs + 0.3);
disp('  Com Eco...'); sound(nota_eco, fs); pause(length(nota_eco)/fs);

% Plot do Eco
figure('Name', 'Efeito: Eco');
t_eco = (0:length(nota_eco)-1) / fs;
plot(t_eco, nota_eco, 'r');
title('Sinal com Eco'); xlabel('Tempo (s)'); ylabel('Amplitude'); grid on;

fprintf('Seção 3 concluída.\n\n');


%% 4. Demonstração da Inserção de Samples
fprintf('--- 4. Demonstrando Inserção de Samples ---\n');
dur_sample = 0.5;
musica_vazia = zeros(1, fs * 2);

% Notas para inserir
nota_sol_sample = geraNota(f_sol, fs, dur_sample, 'quadrada');
nota_la_sample = geraNota(440, fs, dur_sample, 'quadrada');

% Insere as notas na trilha
disp('Construindo sequência: Sol em t=0s, Lá em t=0.7s');
musica_com_samples = insereSample(musica_vazia, nota_sol_sample, 0, fs);
musica_com_samples = insereSample(musica_com_samples, nota_la_sample, 0.7, fs);
sound(musica_com_samples, fs);
pause(length(musica_com_samples)/fs + 0.2);
fprintf('Seção 4 concluída.\n\n');


%% 5. Reprodução da Música Final com Harmonia, Melodia e Efeitos
fprintf('--- 5. Montando e Tocando a Música Final ---\n');
dur_musica = 4;

% --- a. Criar a HARMONIA (sequência de acordes C -> G -> Am -> F) ---
fprintf('Criando harmonia...\n');
harmonia = zeros(1, fs * dur_musica);
dur_acorde_final = 1;

acorde_C = geraNota(261.63,fs,dur_acorde_final,'triangular') + geraNota(329.63,fs,dur_acorde_final,'triangular') + geraNota(392.00,fs,dur_acorde_final,'triangular');
acorde_G = geraNota(392.00,fs,dur_acorde_final,'triangular') + geraNota(493.88,fs,dur_acorde_final,'triangular') + geraNota(587.33,fs,dur_acorde_final,'triangular');
acorde_Am = geraNota(440.00,fs,dur_acorde_final,'triangular') + geraNota(261.63,fs,dur_acorde_final,'triangular') + geraNota(329.63,fs,dur_acorde_final,'triangular');
acorde_F = geraNota(349.23,fs,dur_acorde_final,'triangular') + geraNota(440.00,fs,dur_acorde_final,'triangular') + geraNota(261.63,fs,dur_acorde_final,'triangular');

harmonia = insereSample(harmonia, acorde_C, 0, fs);
harmonia = insereSample(harmonia, acorde_G, 1, fs);
harmonia = insereSample(harmonia, acorde_Am, 2, fs);
harmonia = insereSample(harmonia, acorde_F, 3, fs);

% --- b. Criar a MELODIA ---
fprintf('Criando melodia...\n');
melodia = zeros(1, fs * dur_musica);
dur_nota_melodia = 0.5;

C=261.63; D=293.66; E=329.63; F=349.23; G=392.00;

melodia = insereSample(melodia, geraNota(C,fs,dur_nota_melodia,'seno'), 0, fs);
melodia = insereSample(melodia, geraNota(C,fs,dur_nota_melodia,'seno'), 0.5, fs);
melodia = insereSample(melodia, geraNota(D,fs,dur_nota_melodia,'seno'), 1.0, fs);
melodia = insereSample(melodia, geraNota(C,fs,dur_nota_melodia,'seno'), 1.5, fs);
melodia = insereSample(melodia, geraNota(F,fs,dur_nota_melodia,'seno'), 2.0, fs);
melodia = insereSample(melodia, geraNota(E,fs,dur_nota_melodia,'seno'), 2.5, fs);
melodia = insereSample(melodia, geraNota(G,fs,dur_nota_melodia,'seno'), 3.0, fs);
melodia = insereSample(melodia, geraNota(F,fs,dur_nota_melodia,'seno'), 3.5, fs);

% --- c. Aplicar Efeitos ---
fprintf('Aplicando efeitos...\n');
melodia_fx = vibrato(melodia, fs, 6, 0.002);
harmonia_fx = tremolo(harmonia, fs, 4, 0.2);

% --- d. Mixar e Tocar ---
fprintf('Mixando e normalizando...\n');
musica_final = (harmonia_fx * 0.7) + (melodia_fx * 1.0);
musica_final = musica_final / max(abs(musica_final));

disp('Tocando a MÚSICA FINAL!');
sound(musica_final, fs);
pause(length(musica_final)/fs);

fprintf('\n--- FIM DO SCRIPT ---\n');