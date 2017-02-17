function [ComplexEps] = platinum(wNs)
% [ComplexEps] = platinum(wNs)
%   Creates the complex dielectric function of platinum. Input the frequencies
%   desired, in wavenumbers, as a vector.

wavenumbers=[600 8.07E+02,...
1.05E+03,1.21E+03,1.37E+03,1.61E+03,2.42E+03,3.23E+03,4.03E+03,4.84E+03,...
5.65E+03,6.45E+03,8.07E+03,1.21E+04,1.61E+04];

E1=-[2400 1.83E+03,1.25E+03,9.04E+02,6.92E+02,5.39E+02,2.46E+02,1.22E+02,...
4.42E+01,1.92E+01,1.40E+01,2.14E+01,2.58E+01,1.72E+01,1.13E+01];

E2=[950 1.18E+03,7.28E+02,5.10E+02,3.68E+02,2.83E+02,1.27E+02,6.40E+01,...
6.03E+01,6.93E+01,7.80E+01,7.48E+01,5.63E+01,2.96E+01,1.87E+01];

E1out=interp1(wavenumbers,E1,wNs);
E2out=interp1(wavenumbers,E2,wNs);
ComplexEps = E1out + 1i.*E2out;

end