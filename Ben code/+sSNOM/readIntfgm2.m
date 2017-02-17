function [pos,intfgm] = readIntfgm2(dataMatrix, varargin)
% [pos,intfgm] = readIntfgm(importdata('filename'))
% [pos,intfgm] = readIntfgm(importdata('filename'), demodNum)
%   Reads in a saved interferogram
%   Returns 1D arrays of position and signal  
%   Version 2: for new output format from v2 of LabView program
%   demodNum is the demodulator column to extract (default: 1)
if(~isempty(varargin))
    demodNum = varargin{1};
else
    demodNum = 1;
end

try
    pos = dataMatrix(:,1);
    intfgm = dataMatrix(:,1+demodNum);
catch exception
    warning('Treating as an Anasys file...or trying');
    if(isstruct(dataMatrix))
        dataMatrix = dataMatrix.data;
    end
    pos = dataMatrix(:,1)*1000;
    pos = pos - min(pos);
    intfgm = dataMatrix(:,2);
end
    
pos = pos(intfgm~=0);
intfgm = intfgm(intfgm~=0);
end