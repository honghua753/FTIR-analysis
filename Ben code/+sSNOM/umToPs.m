function [ps] = umToPs(um)
% [ps] = umToFs(um)
%   Converts an array in microns to an array in picoseconds (factoring in
%   backreflection
ps = um*3.336*2/1000;

end
