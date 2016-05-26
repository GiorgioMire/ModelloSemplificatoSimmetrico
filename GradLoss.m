function J=GradLoss(Ts,nu,tau,theta,tnew,Sigma)
% Ts=gpuArray(Ts);
% nu=gpuArray(nu);
% tau=gpuArray(tau);
% theta=gpuArray(theta);
% tnew=gpuArray(tnew);
% Sigma=gpuArray(Sigma);
told=tnew-1;
ep=[];
J=0;
for j=1:length(tnew)
ep=Residual(Ts,nu(:,tnew(j)),nu(:,told(j)),tau(:,told(j)),theta);
J=J+(ep.'*inv(Sigma)*Jeps(Ts,nu(:,told(j)),tau(:,told(j)),theta)).';
end
%     Js=gather(J);
end