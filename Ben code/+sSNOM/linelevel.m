function [Zout] = linelevel(Zin,direction)
% line subtracts AFM height data in either X or Y direction
% example: [Zout] = sSNOM.linelevel(Z,'y');
Zout=Zin;
[m,n]=size(Zin);
if direction=='x'
    for i=1:m
        axis = 1:n;
        [a,~]=polyfit(axis,Zin(i,:),1);
        Zout(i,:)=Zin(i,:)-a(2)-a(1).*axis;
    end
        
elseif direction=='y'
    for i=1:n
        axis = 1:m;
        [a,~]=polyfit(axis',Zin(:,i),1);
        Zout(:,i)=Zin(:,i)-a(2)-a(1).*axis';
    end
else
    disp('pick a direction to linelevel');
end
end

