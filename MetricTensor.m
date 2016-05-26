function G=MetricTensor(Ts,nu,tau,theta,tnew,CovE)
told=tnew-1;
ep=[];
G=0;
for j=1:length(tnew)
G=G+Hess(Ts,nu(:,tnew(j)),nu(:,told(j)),tau(:,told(j)),theta,CovE)
end
G=0.5*(G+G.');
[U,D]=eig(G);
G=U.'*diag(max(abs(diag(D)),1e-3))*U;
G=inv(G)
G=0.5*(G+G.');
[U,D]=eig(G);
G=U.'*diag(max(abs(diag(D)),1e-3))*U
G=0.5*(G+G.');

    
end