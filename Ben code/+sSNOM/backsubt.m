function referenced=backsubt(sample,substrate)
%background subtraction

[stheta, srho]=cart2pol(real(sample),imag(sample));
[btheta, brho]=cart2pol(real(substrate),imag(substrate));

rtheta=unwrap(stheta-btheta);
rrho=srho./brho;
[re, im]=pol2cart(rtheta,rrho);
referenced=re+1i*im;
end

%{
for j=1:20
for i=1:length(subtsample.theta)-1,
    if subtsample.theta(i+1)-subtsample.theta(i)>=1.8,
        subtsample.theta(i+1)=subtsample.theta(i+1)-pi;
    elseif subtsample.theta(i+1)-subtsample.theta(i)<=-1.8;
        subtsample.theta(i+1)=subtsample.theta(i+1)+pi;
    end
end
end

zeropoint=length(subtsample.theta)/2;
subtsample.theta(zeropoint-10:zeropoint+10,1)=0;
limit=.001*max(substrate.rho(zeropoint:zeropoint+zeropoint/2));
for i=1:zeropoint-1;
    if substrate.rho(i+zeropoint)<limit;
        subtsample.theta(i+zeropoint)=subtsample.theta(i-1+zeropoint);
    end
    if substrate.rho(zeropoint-i)<limit;
        subtsample.theta(zeropoint-i)=subtsample.theta(zeropoint+1-i);
    end
end

%}