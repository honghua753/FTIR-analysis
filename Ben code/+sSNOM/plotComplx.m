function [ax] = plotComplx(wNs, vals)
    figure; subplot(2,3,[1,2,4,5]);
    x = reshape(real(vals),1,length(vals));
    y = reshape(imag(vals),1,length(vals));
    z = zeros(size(x));
    col = reshape(wNs,1,length(wNs));
    surface([x;x],[y;y],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',2);
    colorbar('southoutside'); ax=gca; axis equal;
    hold on; plot(0,0);
    ax.XAxisLocation = 'origin';
    ax.YAxisLocation = 'origin';
    subplot(2,3,3); plot(wNs, abs(vals)); title('Amp (a.u.)');
    subplot(2,3,6); plot(wNs, rad2deg(angle(vals))); title('Phase (deg)');
end