function ACFcheck(x)
for dim=1:size(x,1)
    figure
    acf=xcorr(x(dim,:),x(dim,:));
    acfplot=abs(acf(floor(length(acf)/2):end)./max(acf));
    bar(acfplot);
    hold on
    plot(5/100*ones(size(acfplot)),'r')
    hold off
end