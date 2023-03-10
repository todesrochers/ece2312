function [plotAudio] = collectAudio(info, recObj, recDuration, y)

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

%plot data
plotAudio = plot(x, y);
xlabel('Time(s)'); ylabel('Amplitude'); box('off'); 
end

