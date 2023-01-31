function [] = WAVSAVE(info, recObj, recDuration, y,fs)

%gathering device audio inputs and ID
info = audiodevinfo;
info.input(1)
info.input(2)

%Sampling Rate
fs = 44100

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
length(y)
x = (1:recDuration*fs);
x= x/fs;
length(x)

%saving to WAV file
audiowrite("Project1WAV.wav", y, fs);
clear y fs;
audioinfo("Project1WAV.wav")
[y,fs] = audioread('Project1WAV.wav');

%used to prove file is being saved
sound(y,fs)

x = (1:recDuration*fs);
x= x/fs;
plot(x,y)
xlabel('Time(s)');
ylabel('Ampltiude');

%spectogram
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

