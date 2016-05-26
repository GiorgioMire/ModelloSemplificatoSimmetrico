% Calcolo il Jacobiano del residuo rispetto ai parmetri
syms Ts
nu_sensor=sym('nus',[3,1]);
nu_old=sym('nu',[3,1]);
tau=sym('tau',[3,1]);
theta=sym('theta',[8,1]);
ep=Residual(Ts,nu_sensor,nu_old,tau,theta);
Jeps=jacobian(ep,theta);
matlabFunction(Jeps,'file','Jeps.m');
CovE=sym('CovE',[3 3]);
U=ep.'*inv(CovE)*ep/2;
H=hessian(U,theta);
  matlabFunction(H,'file','Hessian.m');
% J=Loss(fe,ep);
% gradJ=jacobian(J,theta);
%  matlabFunction(gradJ,'file','gradJ.m');
%%
clc
for i=1:3
    fprintf('nu%i=nu(%i);\n',i,i)
end
for i=1:3
    fprintf('nus%i=nus(%i);\n',i,i)
end
for i=1:3
    fprintf('tau%i=tau(%i);\n',i,i)
end
for i=1:8
    fprintf('theta%i=theta(%i);\n',i,i)
end
for i=1:3
    for j=1:3
    fprintf('CovE%i_%i=CovE(%i,%i);\n',i,j,i,j)
    end
end
