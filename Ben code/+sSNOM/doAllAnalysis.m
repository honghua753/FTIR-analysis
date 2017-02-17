function [figHandle,wNinRange,sigZOut] = doAllAnalysis(filename, refFilename, titleStr, varargin)
% [figHandle,wNinRange,sigZnorm] = doAllAnalysis(filename, refFilename, titleStr)
% [figHandle,wNinRange,sigZnorm] = doAllAnalysis(filename, refFilename, titleStr, [posMin posMax wnMin wnMax])
% [figHandle,wNinRange,sigZnorm] = doAllAnalysis(filename, refFilename, titleStr, [posMin posMax wnMin wnMax], demodNum)
% [figHandle,wNinRange,sigZnorm] = doAllAnalysis(filename, refFilename, titleStr, [posMin posMax wnMin wnMax], demodNum, autoCenterIntfgm)
%   Reads the signal "filename" and reference "refFilename" files, 
%   plots the baseline-corrected interferograms, and
%   plots the resulting normalized spectra.
%   Saves a png image called "titleStr".png
%   Optionally takes a 4-vector with position and wavenumber axis limits

    if(~isempty(varargin))
        limits = varargin{1};
        posMin = limits(1);
        posMax = limits(2);
        wnMin = limits(3);
        wnMax = limits(4);
        if(length(varargin)>=2)
            demodNum = varargin{2};
        else
            demodNum = 1;
        end
        
        if(length(varargin)>=3)
            autoCenterIntfgm = varargin{3};
        else
            autoCenterIntfgm = true;
        end
    else
        posMin = 0;
        posMax = 6.5;
        wnMin = 1700;
        wnMax = 1800;
    end
    
    [refP,refI] = sSNOM.readIntfgm2(importdata(refFilename),demodNum);
    [sigP,sigI] = sSNOM.readIntfgm2(importdata(filename),demodNum);
        
    figHandle = figure; 
    subplot(3,2,[1 2]); hold on;
    plot(sSNOM.umToPs(refP),sSNOM.normZeroToOne(sSNOM.baselineCorrect2(refI,2)-mean(refI)),'r');
    plot(sSNOM.umToPs(sigP),sSNOM.normZeroToOne(sSNOM.baselineCorrect2(sigI,2)-mean(sigI)),'b');
    xlabel('Delay (ps)');
    axis tight;
    xlim([posMin posMax]);
    title(titleStr);
    legend('Reference','Signal');

    [refW, refZ] = sSNOM.makeSingleSpec(refP, sSNOM.baselineCorrect2(refI,2),2,autoCenterIntfgm);
    [sigW, sigZ] = sSNOM.makeSingleSpec(sigP, sSNOM.baselineCorrect2(sigI,2),2,autoCenterIntfgm);
    sigZinterp = interp1(sigW, sigZ, refW);
%     sigZnorm = sigZinterp./refZ;
    sigZnorm = sSNOM.backsubt(sigZinterp, refZ);
    inRange = (wnMin < refW) & (refW < wnMax);
    wNinRange = refW(inRange);
    sigZOut = sigZnorm(inRange);
    
    smtVal = 1;
    
    subplot(3,2,4); sigRe = real(sigZnorm);
    plot(wNinRange,smooth(sSNOM.baselineCorrect2(sigRe(inRange),1),smtVal));
%     plot(wNinRange,sigRe(inRange));
    xlabel('Wavenumbers (cm^-^1)');
    ylabel('Real part'); axis tight; %axis square;
    
    subplot(3,2,6); sigIm = imag(sigZnorm);
    plot(wNinRange,smooth(sSNOM.baselineCorrect2(sigIm(inRange),1),smtVal));
%    plot(wNinRange,-sigIm(inRange));
    xlabel('Wavenumbers (cm^-^1)');
    ylabel('Imag part'); axis tight; %axis square;
    
    subplot(3,2,3); sigAmp = abs(sigZnorm);
    plot(wNinRange,smooth(sSNOM.baselineCorrect2(sigAmp(inRange),1),smtVal));
%    plot(wNinRange,sigAmp(inRange));
    xlabel('Wavenumbers (cm^-^1)');
    ylabel('Amplitude'); axis tight; %axis square;
    
    subplot(3,2,5); sigPhs = -rad2deg(angle(sigZnorm));
    normPhase = sSNOM.baselineCorrect2(sigPhs(inRange),1);
    plot(wNinRange,smooth(normPhase-min(normPhase),smtVal));
%    plot(wNinRange,-sigPhs(inRange));
    xlabel('Wavenumbers (cm^-^1)');
    ylabel('Phase (deg)'); axis tight; %axis square;
    
    figHandle.PaperPositionMode = 'auto';
    figPos = figHandle.Position;
    figHandle.Position = [figPos(1) figPos(2) 450 700];
    
    print(strcat(titleStr, '.png'), '-dpng', '-r0');
    

end
