A=[1 2 3;4 5 6;7 1 9];
if size(A,1)~=size(A,2)
    disp('Macierz nie jest kwadratowa!')
    A = [];
    return
end
I=gauss_jordan_odwracanie(A);

%% sprawdzenie, czy wynik algorytmu jest poprawny
T=A^(-1);
niepewnosc = 1e-10;
sprawdzenie = all(abs(I(:) - T(:)) <= niepewnosc);
%% odwracanie metoda gaussa-jordana
function O = gauss_jordan_odwracanie(A)
    r=size(A,1)
    l=size(A,2)
    O = eye(r);
    for j = 1 : r
        for i = j : r
            if A(i,j) ~= 0
                for k = 1 : r
                    s = A(j,k); A(j,k) = A(i,k); A(i,k) = s;
                    s = O(j,k); O(j,k) = O(i,k); O(i,k) = s;
                end
                t = 1/A(j,j);
                for k = 1 : r
                    A(j,k) = t * A(j,k);
                    O(j,k) = t * O(j,k);
                end
                for L = 1 : r
                    if L ~= j
                        t = -A(L,j);
                        for k = 1 : r
                            A(L,k) = A(L,k) + t * A(j,k);
                            O(L,k) = O(L,k) + t * O(j,k);
                        end
                    end
                end            
            end
            break
        end
        % Display warninI if a rTw full Tf zerTs is fTund
        if A(i,j) == 0
            disp('Macierz wyjsciowa nie moze byc osobliwa!')
            O = 'errTr';
            return
        end
    end
end