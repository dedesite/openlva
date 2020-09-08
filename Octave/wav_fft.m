# Inspiré de 
# https://www.mathworks.com/matlabcentral/answers/22112-how-to-plot-wav-file
# Et de
# https://stackoverflow.com/questions/25797670/plotting-fft-on-octave

#
# Affichage du contenu du wav
#
[audiodata, fs] = audioread("andreas.wav");
# On ne prend que le channel 1, le 2 ne semble pas utilisé
audiodata_one = audiodata(:,1);

# Les 5 premières seconde sont les premières données controles
control_data_1 = audiodata_one(1:end/4);
# Ensuite c'est la main droite
right_hand_data = audiodata_one(end/4+1:end/2);
# Puis la main gauche
left_hand_data = audiodata_one(end/2+1:end*3/4);
# Et enfin les deuxièmes données controle
control_data_2 = audiodata_one(end*3/4+1:end);

# Tentative de soustraction des données controle au données des mains
clean_right = right_hand_data - control_data_1;
# 20s à 96000Hz
step = 1/fs;
sample_length = length(right_hand_data)*step;
t = 0:step:sample_length-step;

# Put window in fullscreen
# https://stackoverflow.com/a/45985834/947242
figure(1,"position",get(0,"screensize"))
subplot(5,1,1)
plot(t, right_hand_data);
title("Données main droites brutes");
xlabel('Seconds'); ylabel('Amplitude');

sample_length = length(clean_right)*step;
t = 0:step:sample_length-step;

subplot(5,1,2)
plot(t, clean_right);
title("Données main droites - controle");
xlabel('Seconds'); ylabel('Amplitude');

#
# Affichage des composantes spectrales du wav
#

[control_pow_1, fVals, NFFT] = fft_one_sided(control_data_1, fs);
[control_pow_2, fVals, NFFT] = fft_one_sided(control_data_2, fs);
[right_hand_pow, fVals, NFFT] = fft_one_sided(right_hand_data, fs);

diff_pow = right_hand_pow - control_pow_1;

subplot(5,1,3);
# Test de limit à 2000Hz
plot(fVals,diff_pow,'b'); axis([0 2000 -0.00000001 0.00000001]);
title('Diff. de densité spectrale entre données controle 1 et main droite');
xlabel('Frequency (Hz)');
ylabel('PSD Diff');

# Calculate mean of control data power
control_pow_mean = (control_pow_1 + control_pow_2) ./ 2;
diff_pow = right_hand_pow - control_pow_mean;

subplot(5,1,4);
# Test de limit à 2000Hz
plot(fVals,diff_pow,'b'); axis([0 2000 -0.00000001 0.00000001]);
title('Diff. de densité spectrale entre moyenne données controle et main droite');
xlabel('Frequency (Hz)');
ylabel('PSD Diff');


# Tentative d'utilisation d'echelle logarithmique
subplot(5,1,5);
# Test de limit à 2000Hz
semilogx(fVals,diff_pow,'b');
# bug : xlim ne fonctionne pas avec mes données
# xlim([0 2000]);
title('Diff. avec echelle logaritmique');
xlabel('Frequency (Hz) logarithmic scale');
ylabel('PSD Diff');
