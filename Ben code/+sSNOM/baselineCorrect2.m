function [intfgm2, fit] = baselineCorrect2(intfgm, varargin)
% intfgm2 = baselineCorrect2(intfgm)
% intfgm2 = baselineCorrect2(intfgm, deg)
% intfgm2 = baselineCorrect2(intfgm, deg, excludeArry)
%   Performs a polynomial baseline subtraction to correct for drifts
%   deg (optional) is the polynomial degree. Default is 3

if(~isempty(varargin))
    deg = varargin{1};
else
    deg = 3;
end
if(length(varargin)>=2)
    excludeArry = varargin{2};
else
    excludeArry = zeros(size(intfgm));
end
pos = 1:length(intfgm);
pS = size(pos);
iS = size(intfgm);
if(pS(1)==iS(2))
    pos = pos';
end
p = polyfit(pos(~excludeArry),intfgm(~excludeArry),deg);
% intfgm2 = intfgm - polyval(p,pos) + mean(intfgm);
intfgm2 = intfgm - polyval(p,pos);
fit = polyval(p,pos);

% figure; plot(pos, polyval(p,pos)); hold on; plot(pos, intfgm);

end