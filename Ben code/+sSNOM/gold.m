function [ComplexEps] = gold(wNs)
% [ComplexEps] = gold(wNs)
%   Creates the complex dielectric function of gold from Drude Model. 
%   Input the frequencies desired, in wavenumbers, as a vector.

gomegaf=8.06e2;
gomegat=2.16e2;
gomegap=6.20e4;
gEps1=-(gomegap.^2)./(wNs.^2+gomegat.^2);
gEps2=gomegap.^2.*gomegaf./(wNs.^3+wNs.*gomegat^2);
ComplexEps = gEps1 + 1i.*gEps2;
ComplexEps = ComplexEps';

end