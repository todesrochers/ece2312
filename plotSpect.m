function [] = plotSpect(info, recObj, recDuration, y, window, N_overlap);

info = audiodevinfo;
info.input(1)
info.input(2)

%setting up audio recorder 
%sample code: recorder = audiorecorder(Fs,nBits,nChannels,ID)
recObj = audiorecorder;
recObj = audiorecorder(8000,8,2,1);

%record speech
recDuration = 10;
disp("Start speaking")
recordblocking(recObj, recDuration);
disp("Stop speaking")

%store data in array
y = getaudiodata(recObj);

info = audiodevinfo;
info.input(1)
info.input(2)

%setting up audio recorder 
%sample code: recorder = audiorecorder(Fs,nBits,nChannels,ID)
recObj = audiorecorder;
recObj = audiorecorder(44100,8,2,1);

%sample code from project description
window = hamming(512);
N_overlap = 256;
N_fft = 1024;
[S,F,T,P] = spectrogram(y, window, N_overlap, N_fft, 8000,'yaxis');
figure;
surf(T,F,10*log10(P), 'edgecolor', 'none');
axis tight;
view(0,90);
colormap(jet);
set(gca,'clim', [-80,-20]);
ylim([0 8000]);
xlabel('Time (s)'); ylabel('Frequency (Hz)');

end

