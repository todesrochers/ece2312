function [] = REASSEMBLE()
   s1 = audioread("BrownFox.wav");
   Fs = 44100;                  % samples per second
   
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
%PART 4: MIDDLE SECTION
    low = lowpass(down, 1500, 44100);
    downLow = downsample(low, 2, 0);
    
    high = highpass(down, 1500, 44100);
    downHigh = downsample(high, 2, 0);
    
%PART 5:
    %XHH
    xhh = highpass(downHigh, 1500, 44100);
    xhhDOWN = downsample(xhh, 2, 0);
    
    %XHL
    xhl = lowpass(downHigh, 1500, 44100);
    xhlDOWN = downsample(xhl, 2, 0);
    
    %XLH
    xlh = highpass(downLow, 1500, 44100);
    xlhDOWN = downsample(xlh, 2, 0);
    
    %XLL
    xll = lowpass(downLow, 1500, 44100);
    xllDOWN = downsample(xll, 2, 0);
    
    
%REASSEMBLE
  %PART 5:
    %XHH
    xhhUP = upsample(xhhDOWN, 2, 0);
    xhhHIGH = highpass(xhhUP, 1500, 44100);
    
    
    %XHL
    xhlUP = upsample(xhlDOWN, 2, 0);
    xhlLOW = lowpass(xhlUP, 1500, 44100);
    
    %add for FS3 HIGH
    FS3high = xhlLOW + xhhHIGH;
    
    %XLH
    xlhUP = upsample(xlhDOWN, 2, 0);
    xlhHIGH = highpass(xlhUP, 1500, 44100);
    
    
    %XLL
    xllUP = upsample(xllDOWN, 2, 0);
    xllLOW = lowpass(xllUP, 1500, 44100);
    
    %add for FS3 LOW
    FS3low = xlhHIGH + xllLOW;
    
    UPFS3high = upsample(FS3high, 2, 0);
    FS2high = highpass(UPFS3high, 1500, 44100);
    UPFS3low = upsample(FS3low, 2, 0);
    FS2low = lowpass(UPFS3low, 1500, 44100);
    
    %add FS2
    
    FS2 = FS2high + FS2low;
    
    UPFS2 = upsample(FS2, 2, 0);
    FS1 = lowpass(UPFS2, 1500, 44100);
    
    %PLOT FS1
    fs1 = FS1(:,1);
    sampling_freq = 44100;
    window = hamming(512);
    N_overlap = 256;
    N_fft = 1024;
    [S,F,T,P] = spectrogram(fs1, window, N_overlap, N_fft, sampling_freq,'yaxis');

    figure;
    surf(T,F,10*log10(P), 'edgecolor', 'none');
    axis tight;
    view(0,90);   
    colormap(jet);
    set(gca,'clim', [-80,-20]);
    ylim([0 8000]);
    xlabel('Time (s)'); 
    ylabel('Frequency (Hz)');
    title('Reassembled Brown Fox');
    
    
    
   %saving to WAV file
%    audiowrite("Team3-chirp.wav", x, Fs);
%    clear x Fs;
%    audioinfo("Team3-chirp.wav")
%    [x,Fs] = audioread('Team3-synthesized.wav');
end
