%% rozwi¹zanie równania
clear;
load('macierze_zad_3_PZ.mat');
[L, U] = doolittle(A);
n=length(A);
y=zeros(n,1);
for i=1:n
    sum=0.0;
    for j=1:i
        sum=sum+L(i,j)*y(j);
    end
    y(i)=(b(i)-sum)/L(i,i);
end
x=zeros(n,1);
for i=n:-1:1
    sum=0.0;
    for j=i:n
        sum=sum+U(i,j)*x(j);
    end
    x(i)=(y(i)-sum)/U(i,i);
end
disp(x);

%% dok³adnoœæ rozwi¹zania r

R=A*x-b;
sum=0;
for i=1:size(R)
    sum=sum+R(i,1)^2;
end
r=sqrt(sum);
display(r);

%% dok³adnoœæ rozk³adu LU

ERR=A-L*U;
sum=0;
for i=1:size(ERR)
    for j=1:size(ERR)
        sum=sum+ERR(i,j)^2;
    end
end
err=sqrt(sum);
display(err);

%% rozk³ad Doolittle'a
function [L,U]=doolittle(A)
    n=size(A);
    L=zeros(n);
    U=zeros(n);
    for i=1:n 
        L(i,i)=1;
    end
    for i=1:n     
       for j=i:n
           s=0;
           for k=1:i-1
               s=s+L(i,k)*U(k,j); 
           end
           U(i,j)=A(i,j)-s;          
       end
       for j=i+1:n
           s=0;
           for k=1:i-1
               s=s+L(j,k)*U(k,i); 
           end
           L(j,i)=(A(j,i)-s)/U(i,i);          
       end
    end    
end
