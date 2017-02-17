function [Zout] = planelevel(Zin)
% 2D plane AFM height data 
[m,n]=size(Zin);
[Xo, Yo, Zo] = prepareSurfaceData(1:n,1:m,Zin);
fitObj = fit([Xo Yo],Zo,'poly11');
% figure; plot(fitObj,[Xo,Yo],Zo);
Zf = fitObj(Xo, Yo);
Zout = reshape(Zo-Zf,m,n);
end

