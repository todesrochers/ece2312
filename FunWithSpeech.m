function [] = FunWithSpeech(y, fs, Z)
[y,fs] = audioread('Project1WAV.wav');
length(y); %44100*5 = 220500
y1 = y(:,1);
zero_vec = zeros(length(y1),1);
NewOutput = cat(2,y1,zero_vec);

%saving to WAV file
audiowrite("NewOutput.wav", NewOutput, fs);

sound(NewOutput,fs)
end

