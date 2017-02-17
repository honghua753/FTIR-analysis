function [pos,intfgm] = readIntfgm(dataMatrix)
% [pos,intfgm] = readIntfgm(importdata('filename'))
%   Reads in a saved interferogram
%   Returns 1D arrays of position and signal  
try
    pos = dataMatrix(:,4);
    intfgm = dataMatrix(:,5);
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