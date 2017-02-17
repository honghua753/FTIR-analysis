function [filename,X,Y,Z] = loadAnasysImage(xsize,ysize,filestr1,filestr2)
% Loads Anasys Image which has been exported as a CSV. 
%You'll need to know the image size, xsize and ysize, in micrometers

filename=strcat('*',filestr1,'*',filestr2);
temp=length(filename);
if filename(temp-3:temp) == '.csv',
else
filename=strcat(filename,'*','.csv');
end

   
Zname=ls(filename)
Z=importdata(Zname);

[ypix,xpix]=size(Z);
X=linspace(0,xsize,xpix);
Y=linspace(0,ysize,ypix);


figure(1);a=imagesc(X,Y,Z);
 set(gca,'YDir','Reverse');
 colormap('gwyddion');colorbar;
end

