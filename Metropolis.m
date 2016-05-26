clear all
close all
%Carico i dati
load('out');
nu=logsout.getElement('nu').Values.Data.';
tau=logsout.getElement('tau').Values.Data.';
% Tempo di campionamento
s=1;
Ts=0.01*s;
nu=nu(:,1:s:end);
tau=tau(:,1:s:end);
% Temperatura della catena
Temp={1 2 3 10};
%Boltzmann
K=1;
%Stati di partenza
xstar=[288.5  4845.7 0 6824.6 140.07 844.0 0 10].';
Sigma=eye(8);
rising=0;

%Memorizzo gli stati iniziali

N_Chains=4;
for ch=1:N_Chains
    x{ch}=xstar+randi(10);
end
F=0.9;
for it=1:100000
    it
    
%Gradiente del potenziale

 
%finestra temporale
ws=500;
    t=2+it:ws+it;
    CovE=1e-8*eye(3);
    figure(2)
    plot(nu(:,t).')
    %Covarianza del potenziale
    %Potenziale

% if (Temp<0.1 && rising==0) || (Temp>10 && rising==1)
%     F=1/F;
%     rising=~rising
% end
% Sigma=5*eye(8);
%    Temp=Temp*F
%    F
%    rising
%    Series.Temp(it)=Temp;
%    figure(5)
%    plot(Series.Temp)
%    title('temp')
%    drawnow
   % Velocità di diffusione
    
    %Proposal
    

    
   
parfor ch=1:N_Chains;
    d=0.8;
    Sigma=eye(8);
    U=@(x)Loss(Ts,nu,tau,x,t,CovE)/K/Temp{ch};
PI=@(x)exp(-U(x));
DU=@(x)GradLoss(Ts,nu,tau,x,t,CovE)/K/Temp{ch};
qrnd=@(y)mvnrnd((y-d^2/2*Sigma*DU(y)).',d^2*Sigma*2^Temp{ch}).';
    Q=@(y,x)mvnpdf(y,x-d^2/2*Sigma*DU(x),d^2*Sigma*2^Temp{ch});
   xhat{ch}=qrnd(x{ch});
   alpha(it,ch)=exp(-U(xhat{ch})+U(x{ch}))*Q(x{ch},xhat{ch})/Q(xhat{ch},x{ch});
    if rand()<min(1,alpha(it,ch))
        x{ch}=xhat{ch};
%         Series.acceptance{ch}(it)=1;
    else
%         Series.acceptance{ch}(it)=0;
    end
    


end
%Parallel Tempering
for ch=N_Chains:-1:2
chH=ch;
chL=ch-1;
    E=@(x)Loss(Ts,nu,tau,x,t,CovE);
    
Delta=(1/K/Temp{chH}-1/K/Temp{chL})*(E(x{chL})-E(x{chH}));
alpha_swap=min(1,exp(-Delta));
if rand()<min(1,alpha_swap)
xswap=x{chH};
x{chH}=x{chL};
x{chL}=xswap;
end
end
for ch=1:N_Chains
     U=@(x)Loss(Ts,nu,tau,x,t,CovE)/K/Temp{ch};
PI=@(x)exp(-U(x));
DU=@(x)GradLoss(Ts,nu,tau,x,t,CovE)/K/Temp{ch};
    Series.x{ch}(:,it)=x{ch};
Series.DU{ch}(:,it)=DU(x{ch});
Series.U{ch}(it)=U(x{ch});
end
if mod(it,5)==0
grafici
end
if mod(it,10)==0
    save('salvataggio7.mat');
end
figure(245)
plot(alpha(:,4))
title('alpha')
drawnow
end

