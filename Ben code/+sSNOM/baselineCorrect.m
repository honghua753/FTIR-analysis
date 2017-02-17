function intfgm2 = baselineCorrect(pos, intfgm, varargin)
% intfgm2 = baselineCorrect(pos, intfgm)
% intfgm2 = baselineCorrect(pos, intfgm, deg)
%   Performs a polynomial baseline subtraction to correct for drifts
%   deg (optional) is the polynomial degree. Default is 3

if(~isempty(varargin))
    deg = varargin{1};
else
    deg = 3;
end
p = polyfit(pos,intfgm,deg);
intfgm2 = intfgm - polyval(p,pos) + mean(intfgm);

end