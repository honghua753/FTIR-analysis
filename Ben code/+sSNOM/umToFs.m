function [fs] = umToFs(um)
% [ps] = umToFs(um)
%   Converts an array in microns to an array in femtoseconds (factoring in
%   backreflection
fs = um*3.336*2;

end