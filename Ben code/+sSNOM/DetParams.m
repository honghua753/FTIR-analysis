classdef DetParams
% DetParams(lockInTC, harmonic)
% DetParams(lockInTC, harmonic, tRadius, tAmp, tFreq)
% DetParams(lockInTC, harmonic, tRadius, tAmp, tFreq, sampleRate)
% DetParams(lockInTC, harmonic, tRadius, tAmp, tFreq, sampleRate, tLength, gFDM)
% A class to store the instrument-dependent parameters for given s-SNOM
% measurement. Distances measured in nm, frequencies in kHz, times in ms.
% Calculates an array of heights for a single lock-in datapoint when
% tHeights is accessed. 
properties
   harmonic
   lockInTC
   tRadius
   tAmp
   tFreq
   sampleRate
   tLength
   gFDM
end

properties (Dependent)
   tHeights
   harmIndex
end

methods
   function obj = DetParams(lockInTC, harmonic, tRadius, tAmp, tFreq, sampleRate, tLength, gFDM)
       if nargin>=2
           obj.lockInTC = lockInTC;
           obj.harmonic = harmonic;
       else
           obj.lockInTC = 1;
           obj.harmonic = 2;
       end
       if nargin>=5
           obj.tRadius = tRadius;
           obj.tAmp = tAmp;
           obj.tFreq = tFreq;
       else
           obj.tRadius = 20;
           obj.tAmp = 50;
           obj.tFreq = 250;
       end
       if nargin>=6
           obj.sampleRate = sampleRate;
       else
           obj.sampleRate = obj.tFreq*20;
       end
       if nargin>=8
           obj.tLength = tLength;
           obj.gFDM = gFDM;
       else
           obj.tLength = 300;
           obj.gFDM = 0.7*exp(0.06*1i);
       end
   end

   function tHeights = get.tHeights(obj)
       TRadius=obj.tRadius;%tip radius (nm)
       TapAmp=obj.tAmp/2; %tapping setpoint (nm)
       TapFrq=obj.tFreq; %tapping frequency (kHz)
       Time = 0 : (1/obj.sampleRate) : obj.lockInTC; %Time array (ms)
       Zdist=TapAmp*cos(2*pi*TapFrq*Time)+TapAmp; %Sinusoidal Tapping Motion
       tHeights=TRadius+Zdist; %nanometers distance from sample
       if(length(tHeights)>2e4)
           answer = questdlg(...
               sprintf('Number of points for lock-in demodulation is %g',length(tHeights)),...
               'Warning',...
               'Keep that number','Break everything',...
               'Break everything');
           if strcmp(answer,'Break everything')
               tHeights = [];
           end
       end
   end
   
   function idx = get.harmIndex(obj)
       spacing = 1/obj.lockInTC;
       idx = obj.harmonic*obj.tFreq/spacing + 1;
   end
end
    
end