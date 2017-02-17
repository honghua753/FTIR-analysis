function [wNs, X] = makeSingleSpec_noFilter(posZ, intZ, varargin)
% [wNs, X] = makeSingleSpec(posZ, intZ)
% [wNs, X] = makeSingleSpec(posZ, intZ, padPow)
%   Calculates the spectrum from an interferogram
%   Returns complex values X at every wavenumder wNs
%   padPow (optional) is the zero-padding power (default 1)

if(~isempty(varargin))
    padPow = varargin{1};
else
    padPow = 1;
end

% Remove zeros and substract baseline:
pos = posZ(posZ~=0);
int = intZ(posZ~=0);
int = int - mean(int);
%figure; subplot(5,1,1); plot(pos,int); axis tight;

% Calculate and apply filtering function:
% envelope = smooth(abs(int),length(int)/50);
% [~,maxI] = max(envelope);
% halfI = find(envelope > (max(envelope)/2),1);
% stDev = abs(pos(maxI) - pos(halfI)); % St Dev of Gaussian Pulse, in um (30um corresponds to a ~200 fs pulse)
% expTC = max(pos)/2; % Time constant of FID response in um
% cdf = (1/2)*(1+erf((pos - pos(maxI))/(sqrt(2)*stDev)));
% expDecay = exp(-(pos-pos(maxI))/expTC);
% filterFun=expDecay.*cdf;
% intFiltered=filterFun.*int;
intFiltered = int;
%subplot(5,1,2); plot(pos,intFiltered); 
%hold on; plot(pos, max(intFiltered)*filterFun);axis tight;

%Zero-pad:
targetL = 2^(ceil(log2(length(intFiltered)))+padPow-1);
intPad = cat(1,intFiltered,zeros(targetL-length(intFiltered),1));
%subplot(5,1,3); plot(intPad); axis tight;

% Shift so maximum is centered:
[~,maxI] = max(intPad);
shifted=fftshift(circshift(intPad,-maxI));   
%subplot(5,1,4); plot(shifted); axis tight;   

% Calc spectrum
interfft=ifftshift(shifted);
X=fft(fftshift(interfft,length(shifted)));
d = (2*max(pos)/10000)*(length(intPad)/length(int));
wN = 1/d;
wNs = (1:length(intPad))*wN;
wNs = wNs';
end