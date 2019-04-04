%% wprowadzenie danych
%A=[2 1 5 -1.5;5 3 2 4;-2 3 2 -4;4.5 3 5 2];
%b=[1.7;47.3;-46.4;34.95];
A=[1 2 5;3 6 1;2 -1 4];
b=[20;18;12];

if size(A,1)~=size(A,2)
    disp('Macierz nie jest kwadratowa!')
    A=[];
    return
end 
if size(A,1)~=size(b,1)
    disp('Nieprawid³owe wymiary macierzy!')
    A=[];
    return
end
check=A\b;
%% eliminacja gaussa
n=length(A);
max=-1e1000;
for i=1:n
    for q=i:n 
        if max<abs(A(i,q))
            max_row=q;
            max=abs(A(i,q));
        
            tmp = A(i,:);
            A(i,:) = A(max_row,:);
            A(max_row,:) = tmp;
            
            tmp = b(i);
            b(i) = b(max_row);
            b(max_row) = tmp;
        end
    end
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