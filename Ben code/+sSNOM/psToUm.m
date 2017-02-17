function [um] = psToUm(ps)
% [ps] = umToFs(um)
%   Converts an array in microns to an array in femtoseconds (factoring in
%   backreflection
um = ps*1000/(3.336*2);

end
