clear all;
close all;
clc;
fs = 44100; % frequência de amostragem
dur = 1;    % 1 segundo
f0 = 440;   % nota Lá4

% y1 = geraNota(f0, fs, dur, 'seno');
% y2 = geraNota(f0, fs, dur, 'quadrada')
% y3 = geraNota(f0, fs, dur, 'serra');
% y4 = geraNota(f0, fs, dur, 'triangular');
% y5 = geraNota(f0, fs, dur, 'ruido');

fla = 440;
fdo = 261.63;
fmi = 329.63;
fsol = 392;

la = geraNota(fla, fs, dur, 'seno');
do = geraNota(fdo, fs, dur, 'seno');
mi = geraNota(fmi, fs, dur, 'seno');
sol = geraNota(fsol, fs, dur, 'seno');

do_maior = [do mi sol];
la_menor = [la do mi];
sound(do_maior, fs);
sound(la_menor, fs); % toca a nota senoidal

y_sq  = geraNota(f0, fs, dur, 'quadrada');
y_saw = geraNota(f0, fs, dur, 'serra');
y_tri = geraNota(f0, fs, dur, 'triangular');

figure;
subplot(3,1,1); plot(y_sq(1:200)); title('Onda quadrada');
subplot(3,1,2); plot(y_saw(1:200)); title('Onda serra');
subplot(3,1,3); plot(y_tri(1:200)); title('Onda triangular');



fs = 44100;
dur = 1;

% Cria um vetor vazio para 3 segundos de música
musica = zeros(1, fs*3);

% Gera duas notas
nota1 = geraNota(440, fs, dur, 'seno');   % Lá
nota2 = geraNota(523.25, fs, dur, 'seno'); % Dó

% Insere a primeira no início
musica = insereSample(musica, nota1, 0, fs);
musica = insereSample(musica, sol, 1, fs);
% Insere a segunda depois de 1.5 segundos
musica = insereSample(musica, nota2, 1.5, fs);

% Toca resultado
sound(musica, fs);