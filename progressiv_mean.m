function y=progressiv_mean(x)

for j=1:size(x,2)
    y(:,j)=mean(x(:,1:j),2);
end

end