function [] = HIGH()
    s1 = audioread("BrownFox.wav");
    
%DOWNSAMPLING PLOT
    target_F = 8000; %plot cuts off at half of target 
    sampling_freq = 44100/2; %have to keep this same so we get 5 sec

    stopband_st = target_F/sampling_freq;
    passband_end = (target_F-2000)/sampling_freq; %possibly change 2000 (maybe 1900 from previous project)

    F = [0 passband_end stopband_st 1];
    A = [1 1 0 0];
    lpf = firls(256, F, A);
    filtered = filter(lpf, A, s1);
    down = downsample(filtered, 2, 1);
    
%HIGHPASS PLOT
    high = highpass(down, 1500, 44100);
    window = hamming(512);
    N_overlap = 256;
    N_fft = 1024;
       
    %FS3 HIGH HIGHPASS AND DOWNSAMPLE PLOT
    downHigh = downsample(high, 2, 0);
    downHighSpect = downHigh(:,1);
    sampling_freq2 = 44100/4;
    [S,F,T,P] = spectrogram(downHighSpect, window, N_overlap, N_fft, sampling_freq2,'yaxis');

    figure;
    surf(T,F,10*log10(P), 'edgecolor', 'none');
    axis tight;
    view(0,90);   
    colormap(jet);
    set(gca,'clim', [-80,-20]);
    ylim([0 5500]);
    xlabel('Time (s)'); 
    ylabel('Frequency (Hz)');
    title('FS3 Highpass xH[m] of Brown Fox versus Time');
    
%XHH PLOT xHH[i]
    xhh = highpass(downHigh, 1500, 44100);
    
    xhhDOWN = downsample(xhh, 2, 0);
    xhhDOWNSpect = xhhDOWN(:,1);
    sampling_freq3 = 44100/8;
    [S,F,T,P] = spectrogram(xhhDOWNSpect, window, N_overlap, N_fft, sampling_freq3,'yaxis');

    figure;
    surf(T,F,10*log10(P), 'edgecolor', 'none');
    axis tight;
    view(0,90);   
    colormap(jet);
    set(gca,'clim', [-80,-20]);
    ylim([0 2800]);
    xlabel('Time (s)'); 
    ylabel('Frequency (Hz)');
    title('XHH[i] of Brown Fox versus Time');
    
    %XHL 
    xhl = lowpass(downHigh, 1500, 44100);
    
    xhlDOWN = downsample(xhl, 2, 0);
    xhlDOWNSpect = xhlDOWN(:,1);
    sampling_freq3 = 44100/8;
    [S,F,T,P] = spectrogram(xhlDOWNSpect, window, N_overlap, N_fft, sampling_freq3,'yaxis');

    figure;
    surf(T,F,10*log10(P), 'edgecolor', 'none');
    axis tight;
    view(0,90);   
    colormap(jet);
    set(gca,'clim', [-80,-20]);
    ylim([0 2500]);
    xlabel('Time (s)'); 
    ylabel('Frequency (Hz)');
    title('XHL[i] of Brown Fox versus Time');
    
end