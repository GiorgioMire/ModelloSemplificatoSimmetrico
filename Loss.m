function J=Loss(Ts,nu,tau,theta,tnew,Sigma)
told=tnew-1;
ep=[];
J=0;
for j=1:length(tnew)
ep=Residual(Ts,nu(:,tnew(j)),nu(:,told(j)),tau(:,told(j)),theta);
J=J+ep.'*(Sigma\ep)/2;
end
    
end