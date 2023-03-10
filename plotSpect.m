function [] = plotSpect(info, recObj, recDuration, y, window, N_overlap, fs);

info = audiodevinfo;
info.input(1);
info.input(2);

fs = 8000;

%setting up audio recorder 
%sample code: recorder = audiorecorder(Fs,nBits,nChannels,ID)
recObj = audiorecorder;
recObj = audiorecorder(fs,8,2,1);

%record speech
recDuration = 5;
disp("Start speaking")
recordblocking(recObj, recDuration);
disp("Stop speaking")

%store data in array
y = getaudiodata(recObj);

%setting up audio recorder 
recObj = audiorecorder;
recObj = audiorecorder(fs*2,8,2,1);
y1 = y(:,1);

%sample code from project description
window = hamming(512);
N_overlap = 256;
N_fft = 1024;
[S,F,T,P] = spectrogram(y1, window, N_overlap, N_fft, fs*2,'yaxis');

figure;
surf(T,F,10*log10(P), 'edgecolor', 'none');
axis tight;
view(0,90);
colormap(jet);
set(gca,'clim', [-80,-20]);
ylim([0 8000]);
xlabel('Time (s)'); ylabel('Frequency (Hz)');

end

