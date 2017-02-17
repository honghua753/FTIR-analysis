function [wn] = nmToWn(nm)
% [nm] = umToFs(wn)
%   Converts an array in nanometers to an array in wavenumbers (cm^-1)
wn = (1./nm)*(10^7);
end
