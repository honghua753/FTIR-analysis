classdef PDModel
% PDModel(detParams, wNs, epsSample)
% PDModel(detParams, wNs, epsSample, epsTip)
% PDModel(detParams, wNs, epsSample, epsTip, Einc)
% A class for simulating the complex s-SNOM signal demodVal, scattered by a 
% tip and demodulated via a lock-in, using the Point Dipole model, over the 
% spectral values in wNs (in cm^-1).
% detParams is an instance of the sSNOM.DetParams class.
% epsSample, epsTip (def: Pt), are the complex 
% permitivities of the sample, and tip respecivley, at the 
% spectral locations specified by wNs. Einc is the spectrum of the incident 
% field (def: flat response). 

properties
    detParams
    wNs
    epsSample
    epsTip
    Einc
end

properties (Dependent)
    demodVal
end

methods
    function obj = PDModel(detParams, wNs, epsSample, epsTip, Einc)
        if nargin >= 3
            obj.detParams = detParams;
            obj.wNs = wNs;
            obj.epsSample = epsSample;
        else
            obj.detParams = sSNOM.DetParams();
            obj.wNs = linspace(600,4000,2000);
            obj.epsSample = ones(length(obj.wNs),1);
        end
        if nargin >= 4
            obj.epsTip = epsTip;
        else
            obj.epsTip = sSNOM.platinum(obj.wNs);
        end
        if nargin >= 5
            obj.Einc = Einc;
        else
            obj.Einc = ones(length(obj.wNs),1);
        end
        try
            l = length(obj.wNs);
            obj.wNs = reshape(obj.wNs,l,1);
            obj.epsSample = reshape(obj.epsSample,l,1);
            obj.epsTip = reshape(obj.epsTip,l,1);
            obj.Einc = reshape(obj.Einc,l,1);
        catch
            error('Spectral array lengths do not match!');
        end
        
    end
    
    function demodVal = get.demodVal(obj)
        % Define Sample Dielectric Constant and Polarizability
        BetaSample=(obj.epsSample-1)./(obj.epsSample+1);
%         axes(sSNOM.plotComplx(obj.wNs,BetaSample)); title('BetaSample');
        
        % Reflectivity of the Sample
        n2=((abs(obj.epsSample)+real(obj.epsSample))/2).^.5;
        n1=1;
        Rp=( (n1.*(1-(n1./n2.*sin(deg2rad(30))).^2).^.5 - n2.*cos(deg2rad(30))) ./ ...
             (n1.*(1-(n1./n2.*sin(deg2rad(30))).^2).^.5 + n2.*cos(deg2rad(30))) ).^2 ;
%         axes(sSNOM.plotComplx(obj.wNs,Rp)); title('Rp');
        
        % Point Dipole Polarizability
        THeight = obj.detParams.tHeights;
        alphaEff = zeros(length(obj.wNs),length(THeight));
        Etot = alphaEff;
        Itot = alphaEff;
        for i=1:length(THeight); % Calculate at each distance
            alphaEff(:,i)=obj.calcAlphaEff(BetaSample,THeight(i));
            Etot(:,i)=((1+Rp).^2.).*obj.Einc.*(alphaEff(:,i));
            Itot(:,i)=Etot(:,i).*conj(obj.Einc); %bp160616: Should this be complex? Do we need +C.C.?
        end
%         axes(sSNOM.plotComplx(obj.wNs,alphaEff(:,floor(length(THeight)/2)))); title('alphaEff');
%         axes(sSNOM.plotComplx(obj.wNs,Itot(:,floor(length(THeight)/2)))); title('Itot');
        
        % Lock-In Demodulation
        FTsig = zeros(length(obj.wNs),length(THeight));
        for j=1:length(obj.wNs),
           FTsig(j,:)=fft(Itot(j,:));   
        end
        demodVal=FTsig(:,obj.detParams.harmIndex);
%         axes(sSNOM.plotComplx(obj.wNs,demodVal)); title('demodVal');
    end
    
    function alphaEff = calcAlphaEff(obj, BetaSample, H)
        alpha0=(obj.epsTip-1)./(obj.epsTip+2)*4*pi*obj.detParams.tRadius^3;
        alphaEff=alpha0./(1-(alpha0.*BetaSample./(16*pi*(H.^3))));
    end
    
    
end
    
end