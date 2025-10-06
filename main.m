
clear all;
close all;
clc;

% --- Parâmetros Globais ---
fs = 44100; 

%% 1. Demonstração de Notas Simples em Diferentes Formas de Onda
fprintf('--- 1. Gerando Notas com Diferentes Formas de Onda ---\n');
dur = 1;
f0 = 440;

nota_seno = geraNota(f0, fs, dur, 'seno');
nota_quad = geraNota(f0, fs, dur, 'quadrada');
nota_serra = geraNota(f0, fs, dur, 'serra');
nota_tri = geraNota(f0, fs, dur, 'triangular');

disp('Tocando onda Senoidal...'); sound(nota_seno, fs);
pause(length(nota_seno)/fs + 0.2); 
disp('Tocando onda Quadrada...'); sound(nota_quad, fs);
pause(length(nota_quad)/fs + 0.2);
disp('Tocando onda Serra...'); sound(nota_serra, fs);
pause(length(nota_serra)/fs + 0.2);
disp('Tocando onda Triangular...'); sound(nota_tri, fs);
pause(length(nota_tri)/fs + 0.2);

figure('Name', '1. Formas de Onda');
subplot(4,1,1); plot(nota_seno(1:500)); title('Onda Senoidal');
subplot(4,1,2); plot(nota_quad(1:500)); title('Onda Quadrada');
subplot(4,1,3); plot(nota_serra(1:500)); title('Onda Serra');
subplot(4,1,4); plot(nota_tri(1:500)); title('Onda Triangular');
fprintf('Seção 1 concluída.\n\n');

%% 2. Demonstração da Formação de Acordes pela SOMA de Notas
fprintf('--- 2. Formando Acordes por SOMA ---\n');
dur_acorde = 2;
f_do = 261.63;
f_mi = 329.63;
f_sol = 392.00;

nota_do = geraNota(f_do, fs, dur_acorde, 'seno');
nota_mi = geraNota(f_mi, fs, dur_acorde, 'seno');
nota_sol = geraNota(f_sol, fs, dur_acorde, 'seno');

% Cria o acorde
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

% --- Aplica todos os efeitos ---
nota_vibrato = vibrato(nota_base, fs, 6, 0.003);
nota_tremolo = tremolo(nota_base, fs, 7, 0.6);
acorde_decay = decaimento(acorde_base_efeito, fs, 3);
nota_dist = distorcao(nota_base, 0.2);
nota_eco = eco(nota_base, fs, 0.03, 0.8);

% --- Toca todos os efeitos em sequência ---
disp('- Testando Vibrato...'); sound(nota_vibrato, fs); pause(length(nota_vibrato)/fs);
disp('- Testando Tremolo...'); sound(nota_tremolo, fs); pause(length(nota_tremolo)/fs);
disp('- Testando Decaimento...'); sound(acorde_decay, fs); pause(length(acorde_decay)/fs);
disp('- Testando Distorção...'); sound(nota_dist, fs); pause(length(nota_dist)/fs);
disp('- Testando Eco...'); sound(nota_eco, fs); pause(length(nota_eco)/fs);

figure('Name', '3. Demonstração dos Efeitos Sonoros');
samples_40ms = round(0.040 * fs); 

subplot(5,1,1);
plot(nota_vibrato(1:samples_40ms));
title('Vibrato - 40ms');
ylabel('Amplitude');

subplot(5,1,2);
plot(nota_tremolo(1:samples_40ms));
title('Tremolo - 40ms');
ylabel('Amplitude');

subplot(5,1,3);
plot(acorde_decay(1:samples_40ms));
title('Decaimento - 40ms');
ylabel('Amplitude');

subplot(5,1,4);
plot(nota_dist(1:samples_40ms));
title('Distorcao - 40ms');
ylabel('Amplitude');

subplot(5,1,5);
plot(nota_eco(1:samples_40ms));
title('Eco - 40ms');
xlabel('Amostras');
ylabel('Amplitude');
fprintf('Seção 3 concluída.\n\n');

%% 4. Demonstração da Inserção de Samples
fprintf('--- 4. Demonstrando Inserção de Samples ---\n');
dur_sample = 0.5;
musica_vazia = zeros(1, fs * 2);

nota_sol_sample = geraNota(f_sol, fs, dur_sample, 'quadrada');
nota_la_sample = geraNota(440, fs, dur_sample, 'quadrada');

disp('Construindo sequência: Sol em t=0s, Lá em t=0.7s');
musica_com_samples = insereSample(musica_vazia, nota_sol_sample, 0, fs);
musica_com_samples = insereSample(musica_com_samples, nota_la_sample, 0.7, fs);
sound(musica_com_samples, fs);
pause(length(musica_com_samples)/fs + 0.2);

% --- PLOT ADICIONADO PARA A SEÇÃO 4 ---
figure('Name', '4. Sequência de Notas');
t_seq = (0:length(musica_com_samples)-1) / fs;
plot(t_seq, musica_com_samples);
title('Parte 4 - Sequência de notas com insereSample');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;
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
% Ajusta o volume relativo (melodia um pouco mais alta)
musica_final = (harmonia_fx * 0.7) + (melodia_fx * 1.0);
% Normaliza o resultado final
musica_final = musica_final / max(abs(musica_final));

disp('Tocando a MÚSICA FINAL!');
sound(musica_final, fs);
pause(length(musica_final)/fs);

figure('Name', '5. Composição Final');
t_final = (0:length(musica_final)-1) / fs;
plot(t_final, musica_final);
title('Parte 5 - Composição Final (Harmonia + Melodia)');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;

fprintf('\n--- FIM DO SCRIPT ---\n');
