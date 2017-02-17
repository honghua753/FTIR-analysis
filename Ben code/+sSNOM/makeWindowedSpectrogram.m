function [wNs, pos, WinFFTs] = makeWindowedSpectrogram(posZ, intZ, varargin) 
%  [wNs, WinFFTs] = makeWindowedSpectrogram(posZ, intZ, [windowWidth]) 
% Gaussian windowed Fourier transform of an interferogram
% Plot with imagesc(wNs, pos, WinFFTs);

if(~isempty(varargin))
    windowWidth = varargin{1};
else
    windowWidth = 50; % in um
end

pos = posZ(posZ~=0);
int = intZ(posZ~=0);

nWindows = length(pos);
windowSpacing = (max(pos) - min(pos))/nWindows;
WinFFTs = zeros(nWindows);
for i = 1:nWindows
   gaussF = gauss((i-0.5)*windowSpacing + min(pos),windowWidth,pos);
   sigTWindow = int.*gaussF;
   [wNs,ampl] = doFFT(pos,sigTWindow);
   WinFFTs(:,i) = ampl;
   
%    if(i==ceil(nWindows/2))
%        figure; plot(posZ, sSNOM.normZeroToOne(intZ));hold on;
%        plot(pos, gaussF,'k');
%    end
end


end

function [Y] =  gauss(mu,sigma,X)
Y = exp(-((X-mu).^2)/(2*sigma^2));
Y = Y/max(Y);
end

function [wNs,ampl] = doFFT(pos,sig)
X=fft(fftshift(ifftshift(sig),length(sig)));
ampl = abs(X);
d = (2*max(pos)/10000);
wN = 1/d;
wNs = (1:length(sig))*wN;
end