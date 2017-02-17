classdef FDModel < sSNOM.PDModel
% FDModel(detParams, wNs, epsSample)
% FDModel(detParams, wNs, epsSample, epsTip)
% FDModel(detParams, wNs, epsSample, epsTip, Einc)
% A class for simulating the complex s-SNOM signal demodVal, scattered by a 
% tip and demodulated via a lock-in, using the Finite Dipole model, over the 
% spectral values in wNs (in cm^-1).
% detParams is an instance of the sSNOM.DetParams class.
% epsSample, epsTip (def: Pt), are the complex 
% permitivities of the sample, and tip respecivley, at the 
% spectral locations specified by wNs. Einc is the spectrum of the incident 
% field (def: flat response). 
    
methods
    function obj = FDModel(varargin)
        obj@sSNOM.PDModel(varargin{1:length(varargin)});
    end
    
   function alphaEff = calcAlphaEff(obj, BetaSample, H)
       R = obj.detParams.tRadius;
       L = obj.detParams.tLength;
       g = obj.detParams.gFDM;
       alphaEff= R^2*L * (2*L/R + log(R/(4*exp(1)*L))) ./ log(4*L/(exp(1)^2)) * ...
           ( 2 + (BetaSample*(g-((R+H)/L))*log(4*L/(4*H + 3*R))) ./ ...
           (log(4*L/R) - BetaSample*(g - (3*R-4*H)/(4*L))*log(2*L/(2*H+R))) );
    end 
end

end