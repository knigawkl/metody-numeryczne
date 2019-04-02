A=[6 3 6;2 3 5;-1 2 4];
if size(A,1)~=size(A,2)
    disp('Macierz nie jest kwadratowa!')
    A=[];
    return
end
I=gauss_jordan_odwracanie(A);
%% sprawdzenie, czy wynik algorytmu jest poprawny
niepewnosc=1e-10;
T=A^(-1);
if size(I)==size(T)
    sprawdzenie = all(abs(I(:) - T(:)) <= niepewnosc);
end
%% odwracanie metoda gaussa-jordana
function A = gauss_jordan_odwracanie(A)
    n=size(A,1);
    for k=1:n
        for i=1:n
            d=A(k,k);
            if i~=k
                A(i,k)=A(i,k)/d;
            end
        end      
        for i=1:n
            for j=1:n
                if j~=k && i~=k
                    A(i,j)=A(i,j)-A(i,k)*A(k,j);
                end
            end
        end
        for j=1:n
            if j~=k
                A(k,j)=-A(k,j)/A(k,k);
            end
        end
        A(k,k)=1/A(k,k);
    end
end