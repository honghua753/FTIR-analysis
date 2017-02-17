function [] = processSpectra_sample22()

% Note: this is done with no auto-centering of the interferograms
% (see line 44-46 of sSNOM.makeSingleSpec)

bounds = [4.5 9 1200 1400];

[figHandle,wNinRangeA,sigZOutA] = sSNOM.doAllAnalysis(sSNOM.findFile('002*txt'), ...
    sSNOM.findFile('001*txt'), ...
    '002 s1833 2H', bounds,1,false);
close(figHandle);

bounds = [4.5 9 1030 1200];

[figHandle,wNinRangeB,sigZOutB] = sSNOM.doAllAnalysis(sSNOM.findFile('005*txt'), ...
    sSNOM.findFile('004*txt'), ...
    '005 s1865 2H', bounds,1,false);
close(figHandle);

bounds = [4.5 9 1150 1295];

[figHandle,wNinRangeC,sigZOutC] = sSNOM.doAllAnalysis(sSNOM.findFile('010*txt'), ...
    sSNOM.findFile('006*txt'), ...
    '010 s1857 2H', bounds,1,false);
close(figHandle);

iA = -imag(sigZOutA);
iB = -imag(sigZOutB);
iC = -imag(sigZOutC);

figure; plot(wNinRangeB, iB); 
hold on; plot(wNinRangeA, iA);
plot(wNinRangeC, iC);
title('Sample 22: Original data'); 
xlabel('Wavenumber (cm^-^1)'); ylabel('s-SNOM Imag');

figure; plot(wNinRangeB, iB); 
hold on; plot(wNinRangeA, iA - (iA(1) - iB(end)));
plot(wNinRangeC, iC);
title('Sample 22: Shifted data');
xlabel('Wavenumber (cm^-^1)'); ylabel('s-SNOM Imag');

iA = .62*iA;
figure; plot(wNinRangeB, iB); 
hold on; plot(wNinRangeA, iA - (iA(1) - iB(end)));
plot(wNinRangeC, iC);
title('Sample 22: Shifted, Scaled data');
xlabel('Wavenumber (cm^-^1)'); ylabel('s-SNOM Imag');

csvwrite('sample22_s1865_2H.csv',cat(2,wNinRangeB, iB))
csvwrite('sample22_s1833_2H.csv',cat(2,wNinRangeA, iA - (iA(1) - iB(end))));
csvwrite('sample22_s1857_2H.csv',cat(2,wNinRangeC, iC));

end