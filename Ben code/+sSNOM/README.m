minWN = 1850;
maxWN = 2010;

[pos,intfgm] = sSNOM.readIntfgm(importdata('filename'));
[wNs, X] = sSNOM.makeSingleSpec(pos, sSNOM.baselineCorrect(pos, intfgm),2);

[posRef,intfgmRef] = sSNOM.readIntfgm(importdata('filenameRef'));
[wNsRef, Xref] = sSNOM.makeSingleSpec(pos, sSNOM.baselineCorrect(pos, intfgm),2);

XI = interp1(wNs, X, wNsRef);
Xnorm = sSNOM.backsubt(XI,Xref); 

figure; subplot(2,1,1); plot(wNsRef, abs(Xnorm)); xlim([minWN maxWN]); ylabel('Amplitude (a.u.)');
subplot(2,1,2); plot(wNsRef, rad2deg(angle(Xnorm))); xlim([minWN maxWN]); ylabel('Phase (deg)');
xlabel('Wavenumber (cm^-^1)');

%---OR---
[figHandle,wNinRange,sigZnorm] = sSNOM.doAllAnalysis(sSNOM.findFile('filenamePart'), sSNOM.findFile('refFilenamePart'), titleStr, [posMin posMax wnMin wnMax])
