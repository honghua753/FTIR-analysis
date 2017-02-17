function [] = processSpectra()

bounds = [1.5 4 1000 1350];

[figHandle,wNinRangeA,sigZOutA] = sSNOM.doAllAnalysis(sSNOM.findFile('004*txt'), ...
    sSNOM.findFile('003*txt'), ...
    '004 uMasch s1840 2H', bounds,1,true);

save('161208.mat','wNinRangeA','sigZOutA');

% sSNOM.plotComplx(wNinRangeA,sigZOutA);

% csvwrite('sample4_s1857_2H.csv',cat(2,wNinRangeA,detrend(real(sigZOutA)),detrend(-imag(sigZOutA))));

% [figHandle,wNinRangeA,sigZOutA] = sSNOM.doAllAnalysis(sSNOM.findFile('002*txt'), ...
%     sSNOM.findFile('001*txt'), ...
%     '002 s1857 3H', bounds,2);

end