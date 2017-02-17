function [ComplexEps] = lorentzian(wNs, strengths, peaks, widths, varargin)
% [ComplexEps] = lorentzian(wNs, strengths, peaks, widths)
% [ComplexEps] = lorentzian(wNs, strengths, peaks, widths, angles)
% [ComplexEps] = lorentzian(wNs, strengths, peaks, widths, angles, epsInf)
% [ComplexEps] = lorentzian(wNs, strengths, peaks, widths, angles, epsInf, plot)
% Calculates the complex epsilon ComplexEps for theoretical lorentzian
% oscillator(s). Based off of Eric's "Carbonyl.m" code [Physica B 292
% (2000) 286}295]
%   wNs is the wavenumber range of interest
%   strengths is an array of the oscillator strength of each eigenmode
%   peaks is an array of the center wavenumbers of the eigenmodes
%   widths is an array of the FWHM of each eigenmode
%   angle (optional) is the angle offsets in the complex plane (dflt:0deg)
%   epsInf (optional) is the non-resonant offset (dflt:1)
%   plot (optional) is a boolean value (dflt:false)

    switch(length(varargin))
        case 0
            theta = zeros(1,length(strengths));
            epsInf = 1;
            plt = false;
        case 1
            theta = varargin{1};
            epsInf = 1;
            plt = false;
        case 2
            theta = varargin{1};
            epsInf = varargin{2};
            plt = false;
        case 3
            theta = varargin{1};
            epsInf = varargin{2};
            plt = varargin{3};
        otherwise
            error('Too many animals!');
    end

    wNs = reshape(wNs,length(wNs),1);
    %strengths=.51e-4*.07*strengths; % Eric, why?

    ComplexEps=zeros(length(wNs),1);
    for i=1:length(strengths),
        ComplexEps=ComplexEps + ...
            exp(1i*deg2rad(theta(i)))*(strengths(i)*peaks(i)*widths(i)) ./ ...
            ((peaks(i).^2-wNs.^2)-1i*widths(i).*wNs);
    end

    ComplexEps=ComplexEps+epsInf;
    
    if plt
        ax = sSNOM.plotComplx(wNs,ComplexEps);
        %axes(ax); xlim([0 2]); ylim([-1 1]); 
    end
end


           % sin(deg2rad(angle))*(strengths(i)*peaks(i).^2) ./ ...