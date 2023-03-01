function [] = LOW()
    s1 = audioread("BrownFox.wav");
    
%PART 3: LOWPASS AND DOWNSAMPLE
    target_F = 8000; %plot cuts off at half of target 
    sampling_freq = 44100/2; %have to keep this same so we get 5 sec

    stopband_st = target_F/sampling_freq;
    passband_end = (target_F-2000)/sampling_freq;

    F = [0 passband_end stopband_st 1];
    A = [1 1 0 0];
    lpf = firls(256, F, A);
    filtered = filter(lpf, A, s1);
    down = downsample(filtered, 2, 1);
    
%FS3: LOWPASS AND DOWNSAMPLE PLOT xL[m]
    low = lowpass(down, 1500, 44100);
    
    downLow = downsample(low, 2, 0);
    downLowSpect = downLow(:,1);
    sampling_freq2 = 44100/4;
    window = hamming(512);
    N_overlap = 256;
    N_fft = 1024;
    [S,F,T,P] = spectrogram(downLowSpect, window, N_overlap, N_fft, sampling_freq2,'yaxis');

    figure;
    surf(T,F,10*log10(P), 'edgecolor', 'none');
    axis tight;
    view(0,90);   
    colormap(jet);
    set(gca,'clim', [-80,-20]);
    ylim([0 5500]);
    xlabel('Time (s)'); 
    ylabel('Frequency (Hz)');
    title('FS3 Lowpass xL[m] of Brown Fox versus Time');
    
%XLL PLOT xLL[i]
    xll = lowpass(downLow, 1500, 44100);

    xllDOWN = downsample(xll, 2, 0);
    xllDOWNSpect = xllDOWN(:,1);
    sampling_freq3 = 44100/8;
    [S,F,T,P] = spectrogram(xllDOWNSpect, window, N_overlap, N_fft, sampling_freq3,'yaxis');

    figure;
    surf(T,F,10*log10(P), 'edgecolor', 'none');
    axis tight;
    view(0,90);   
    colormap(jet);
    set(gca,'clim', [-80,-20]);
    ylim([0 2500]);
    xlabel('Time (s)'); 
    ylabel('Frequency (Hz)');
    title('xLL[i] of Brown Fox versus Time');
    
%XLH PLOT xLH[i]
    xlh = highpass(downLow, 1500, 44100);
    
    xlhDOWN = downsample(xlh, 2, 0);
    xlhDOWNSpect = xlhDOWN(:,1);
    sampling_freq2 = 44100/4;
    [S,F,T,P] = spectrogram(xlhDOWNSpect, window, N_overlap, N_fft, sampling_freq2,'yaxis');

    figure;
    surf(T,F,10*log10(P), 'edgecolor', 'none');
    axis tight;
    view(0,90);   
    colormap(jet);
    set(gca,'clim', [-80,-20]);
    ylim([0 5500]);
    xlabel('Time (s)'); 
    ylabel('Frequency (Hz)');
    title('xLH[i] of Brown Fox versus Time');

end
