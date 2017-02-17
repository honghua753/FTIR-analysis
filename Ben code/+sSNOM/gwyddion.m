function J = gwyddion(m)
%JET    Variant of HSV
%   JET(M), a variant of HSV(M), is an M-by-3 matrix containing
%   the default colormap used by CONTOUR, SURF and PCOLOR.
%   The colors begin with dark blue, range through shades of
%   blue, cyan, green, yellow and red, and end with dark red.
%   JET, by itself, is the same length as the current figure's
%   colormap. If no figure exists, MATLAB creates one.
%
%   See also HSV, HOT, PINK, FLAG, COLORMAP, RGBPLOT.

%   Copyright 1984-2004 The MathWorks, Inc.
%   $Revision: 5.7.4.2 $  $Date: 2005/06/21 19:31:40 $

if nargin < 1
   m = size(get(gcf,'colormap'),1);
end


firstpart=floor(m/3);
secondpart=floor(2*m/3);
%thirdpart=floor(3*m/4);
%blacktobrown
J(1:firstpart,1) = linspace(0,168/255,firstpart);
J(1:firstpart,2) = linspace(0,40/255,firstpart);
J(1:firstpart,3) = linspace(0,15/255,firstpart);

%browntoyellow
J(firstpart+1:secondpart,1) = linspace(168/255,243/255,secondpart-firstpart);
J(firstpart+1:secondpart,2) = linspace(40/255,194/255,secondpart-firstpart);
J(firstpart+1:secondpart,3) = linspace(15/255,93/255,secondpart-firstpart);

%yellowtowhite
J(secondpart+1:m,1) = linspace(243/255,1,m-secondpart);
J(secondpart+1:m,2) = linspace(194/255,1,m-secondpart);
J(secondpart+1:m,3) = linspace(93/255,1,m-secondpart);


