function [nm] = wnToNm(wn)
% [nm] = umToFs(wn)
%   Converts an array in wavenumbers (cm^-1) to an array in nanometers
nm = (1./wn)*(10^7);
end
