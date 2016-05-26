figure(10)
for j=1:8
subplot(2,4,j)
for ch=1%1:N_Chains
h=histogram(Series.x{ch}(j,:),'normalization','probability','FaceAlpha',0.5);
[~,idx]=max(h.Values);
best{ch}(j)=mean([h.BinEdges(idx),h.BinEdges(idx+1)])
hold on
end
hold off
end
figure(11)
for j=1:8
    for ch=1:N_Chains
subplot(2,4,j)
plot(Series.x{ch}(j,:))
hold on
    end
    hold off
end
figure(12)
for ch=1:N_Chains
    
plot(Series.U{ch})
hold on
end
hold off

drawnow