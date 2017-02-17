function [wNs, X] = makeSingleSpec(posZ, intZ, varargin)
% [wNs, X] = makeSingleSpec(posZ, intZ)
% [wNs, X] = makeSingleSpec(posZ, intZ, padPow)
%   Calculates the spectrum from an interferogram
%   Returns complex values X at every wavenumder wNs
%   padPow (optional) is the zero-padding power (default 0)

if(~isempty(varargin))
    padPow = varargin{1};
else
    padPow = 0;
end

% Remove zeros to avoid errors
pos = posZ(posZ~=0);
int = intZ(posZ~=0);

% Zero-padding:
targetL = 2^(ceil(log2(length(int)))+padPow-1);
intPad = cat(1,zeros(targetL,1),int,zeros(targetL,1));

%Find interferogram maximum and shift
[~,maxI] = max(intPad);
intShifted=fftshift(circshift(intPad,-maxI));

%Define and apply error function filter
erfx=linspace(-pi/2,pi/2,length(intShifted));
erfy=(exp(-erfx*2).*(erf(erfx*4)+1))'+0.0;
intFiltered=erfy.*intShifted;    

% Calc spectrum
interfft=ifftshift(intFiltered);
X=fft(fftshift(interfft,length(intFiltered)));
d = (2*max(pos)/10000)*(length(intFiltered)/length(int));
wN = 1/d;
wNs = (1:length(intFiltered))*wN;
wNs = wNs';

end
