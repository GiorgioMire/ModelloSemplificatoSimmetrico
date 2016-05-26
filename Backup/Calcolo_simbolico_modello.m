% Skew Operator
skew=@(v)[0 -v(3) v(2);v(3) 0 -v(1); -v(2) v(1) 0];
simm=@(m)triu(m)+triu(m).'-diag(diag(m));
M=simm(sym('m',[6 6]));
D=simm(sym('d',[6 6]));
% Applico simmetria port-starboard
for i=1:6
    for j=1:6
        M(i,j)=(1-mod(i+j,2))*M(i,j);
        D(i,j)=(1-mod(i+j,2))*D(i,j);
    end
end
nu=sym('nu',[6,1]);
tau=sym('tau',[6,1]);
syms Ts;
nu([3 4 5])=zeros(3,1);
C=[zeros(3) -skew(M(1:3,:)*nu);-skew(M(1:3,:)*nu) -skew(M(4:6,:)*nu)];
% Applico riduazione al piano orizzontale
sel=[1 2 6];
M=M(sel,sel);
C=C(sel,sel);
D=D(sel,sel);
nu=nu(sel);
tau=tau(sel)
nudot=inv(M)*(tau-C*nu-D*nu);
Output=nu+nudot*Ts;
str=char(Output);
for i=1:6
    oldSubstr=sprintf('nu%i',i);
    l=i;
    if i==6
        l=3;
    end
    newSubstr=sprintf('nu(%i)',l);
    str = strrep(str, oldSubstr, newSubstr);
        oldSubstr=sprintf('tau%i',i);
    newSubstr=sprintf('tau(%i)',l);
    str = strrep(str, oldSubstr, newSubstr);
end
for i=1:6
    for j=1:6
          l=i;
          k=j;
    if i==6
        l=3;
    end
    if j==6
        k=3;
    end
    oldSubstr=sprintf('m%i_%i',i,j);
    newSubstr=sprintf('m(%i,%i)',l,k);
    str = strrep(str, oldSubstr, newSubstr);
        oldSubstr=sprintf('d%i_%i',i,j);
    newSubstr=sprintf('d(%i,%i)',l,k);
    str = strrep(str, oldSubstr, newSubstr);
    end
end

Output=sym(str);
matlabFunction(Output,'file','SystemOutput.m')
%%
Output=nudot;
str=char(Output);
for i=1:6
    oldSubstr=sprintf('nu%i',i);
    l=i;
    if i==6
        l=3;
    end
    newSubstr=sprintf('nu(%i)',l);
    str = strrep(str, oldSubstr, newSubstr);
        oldSubstr=sprintf('tau%i',i);
    newSubstr=sprintf('tau(%i)',l);
    str = strrep(str, oldSubstr, newSubstr);
end
for i=1:6
    for j=1:6
          l=i;
          k=j;
    if i==6
        l=3;
    end
    if j==6
        k=3;
    end
    oldSubstr=sprintf('m%i_%i',i,j);
    newSubstr=sprintf('m(%i,%i)',l,k);
    str = strrep(str, oldSubstr, newSubstr);
        oldSubstr=sprintf('d%i_%i',i,j);
    newSubstr=sprintf('d(%i,%i)',l,k);
    str = strrep(str, oldSubstr, newSubstr);
    end
end

Output=sym(str);
matlabFunction(Output,'file','nudot.m')
