function [] = processSpectra_sample21()

% Note: this is done WITH auto-centering of the interferograms
% (see line 44-46 of sSNOM.makeSingleSpec)

bounds = [4.5 9 1200 1400];

[figHandle,wNinRangeA,sigZOutA] = sSNOM.doAllAnalysis(sSNOM.findFile('012*txt'), ...
    sSNOM.findFile('011*txt'), ...
    '012 s1833 2H', bounds,1,true);
close(figHandle);

bounds = [4.5 9 1030 1200];

[figHandle,wNinRangeB,sigZOutB] = sSNOM.doAllAnalysis(sSNOM.findFile('015*txt'), ...
    sSNOM.findFile('014*txt'), ...
    '015 s1865 2H', bounds,1,true);
close(figHandle);

bounds = [4.5 9 1150 1295];

[figHandle,wNinRangeC,sigZOutC] = sSNOM.doAllAnalysis(sSNOM.findFile('017*txt'), ...
    sSNOM.findFile('016*txt'), ...
    '017 s1857 2H', bounds,1,true);
close(figHandle);

iA = -imag(sigZOutA);
iB = -imag(sigZOutB);
iC = -imag(sigZOutC);

figure; plot(wNinRangeB, iB); 
hold on; plot(wNinRangeA, iA);
plot(wNinRangeC, iC);
title('Sample 21: Original data'); 
xlabel('Wavenumber (cm^-^1)'); ylabel('s-SNOM Imag');

figure; plot(wNinRangeB, iB + (iA(1) - iB(end))); 
hold on; plot(wNinRangeA, iA);
plot(wNinRangeC, iC-.0183);
title('Sample 21: Shifted data');
xlabel('Wavenumber (cm^-^1)'); ylabel('s-SNOM Imag');

iB = 4*iB;
figure; plot(wNinRangeB, iB + (iA(1) - iB(end))); 
hold on; plot(wNinRangeA, iA);
plot(wNinRangeC, iC-.0183);
title('Sample 21: Shifted, Scaled data');
xlabel('Wavenumber (cm^-^1)'); ylabel('s-SNOM Imag');

csvwrite('sample21_s1865_2H.csv',cat(2,wNinRangeB,iB + (iA(1) - iB(end))))
csvwrite('sample21_s1833_2H.csv',cat(2,wNinRangeA,iA));
csvwrite('sample21_s1857_2H.csv',cat(2,wNinRangeC,iC-.0183));

end