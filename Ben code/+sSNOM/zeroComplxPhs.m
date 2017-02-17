function Zz = zeroComplxPhs(Z)
% Rotates the complex values Z around the origin of the complex plane by 
% the minimum angle of Z, to make the function touch the real axis.
    Zz = Z*exp(-1i*min(angle(Z)));
end