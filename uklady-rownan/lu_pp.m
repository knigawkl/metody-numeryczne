A=[5 3 2; 1 2 0; 3 0 4];
b=[10 5 -2]';
%L= choleski(A);
[L, U] = doolittle(A);
y=L\b;
x=U\y
%%
function L=choleski(A)
    n=size(A);
    L=zeros(n);
    for k=1:n
        s=0;
        for j=1:k-1
            s=s+L(k,j)^2;
        end
        L(k,k)=sqrt(A(k,k)-s);
        for i=k+1:n
            s=0;
            for j=1:k-1
                s=s+L(i,j)*L(k,j);
            end
            L(i,j)=(A(i,k)-s)/L(k,k);
        end        
    end
end

%%
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
