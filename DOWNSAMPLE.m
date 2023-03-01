function [] = DOWNSAMPLE()
    s1 = audioread("BrownFox.wav");
    fs = 44100;
    
%ORIGINAL PLOT
    %creates the spectrogram plot
    original = s1(:,1);
    window = hamming(512);
    N_overlap = 256;
    N_fft = 1024;
    [S,F,T,P] = spectrogram(original, window, N_overlap, N_fft, fs,'yaxis');

    figure;
    surf(T,F,10*log10(P), 'edgecolor', 'none');
    axis tight;
    view(0,90);   
    colormap(jet);
    set(gca,'clim', [-80,-20]);
    ylim([0 8000]);
    xlabel('Time (s)'); 
    ylabel('Frequency (Hz)');
    title('FS1 xORIG[n] of Brown Fox versus Time');
    
%FS2: LOWPASS AND DOWNSAMPLE OF ORIGINAL PLOT
    target_F = 8000; %plot cuts off at half of target 
    sampling_freq = 44100/2; %have to keep this same so we get 5 sec

    stopband_st = target_F/sampling_freq;
    passband_end = (target_F-2000)/sampling_freq; 

    F = [0 passband_end stopband_st 1];
    A = [1 1 0 0];
    %lowpass filter
    lpf = firls(256, F, A);
    filtered = filter(lpf, A, s1);
    %downsample of lowpass
    down = downsample(filtered, 2, 0);
    
    %creates the spectrogram plot
    downSpect = down(:,1);
    [S,F,T,P] = spectrogram(downSpect, window, N_overlap, N_fft, sampling_freq,'yaxis');

    figure;
    surf(T,F,10*log10(P), 'edgecolor', 'none');
    axis tight;
    view(0,90);   
    colormap(jet);
    set(gca,'clim', [-80,-20]);
    ylim([0 8000]);
    xlabel('Time (s)'); 
    ylabel('Frequency (Hz)');
    title('FS2 x[k] of Brown Fox versus Time');
end