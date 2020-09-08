# Inspiré de 
# https://www.mathworks.com/matlabcentral/answers/22112-how-to-plot-wav-file
# Et de
# https://stackoverflow.com/questions/25797670/plotting-fft-on-octave

#
# Affichage du contenu du wav
#
[audiodata, fs] = wavread("andreas.wav");
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

subplot(4,1,1)
plot(t, right_hand_data);
title("Données main droites brutes");
xlabel('Seconds'); ylabel('Amplitude');

sample_length = length(clean_right)*step;
t = 0:step:sample_length-step;

subplot(4,1,2)
plot(t, clean_right);
title("Données main droites - controle");
xlabel('Seconds'); ylabel('Amplitude');

#
# Affichage des composantes spectrales du wav
#
  
[Px, fVals, NFFT] = fft_one_sided(clean_right, fs);
subplot(4,1,3);     
# Test de limit à 845Hz
plot(fVals,Px(1:NFFT/2),'b'); axis([0 845 0 0.0000001]);
title('One Sided Power Spectral Density');       
xlabel('Frequency (Hz)')         
ylabel('PSD');
