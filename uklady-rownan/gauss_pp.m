%% wprowadzenie danych
A=[2 1 5 -1.5;5 3 2 4;-2 3 2 -4;4.5 3 5 2];
b=[1.7;47.3;-46.4;34.95];
if size(A,1)~=size(A,2)
    disp('Macierz nie jest kwadratowa!')
    A=[];
    return
end
check=A\b;
%% eliminacja gaussa
n=length(A);
for i=1:n
   for j=i+1:n       
       k=A(j,i)/A(i,i);
       A(j,:)=A(j,:)-A(i,:)*k;
       b(j)=b(j)-b(i)*k;
   end
end
%% podstawianie wsteczne
x=zeros(n,1);
for i=n:-1:1
    sum=0.0;
    for j=i:n
        sum=sum+A(i,j)*x(j);
    end
    x(i)=(b(i)-sum)/A(i,i);
end
niepewnosc=1e-10;
sprawdzenie=all(abs(check(:)-x(:)) <= niepewnosc);