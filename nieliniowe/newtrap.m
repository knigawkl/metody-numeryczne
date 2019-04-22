clear;
[y, no, tab] = newton(1);
y
no

%%
function f=fun(x)
    f = 3.55*x^3 - 1.1*x^2 - 0.765*x + 0.74;
end

%%
function f=dfun(x)
    f = 10.65*x^2 - 2.2*x - 0.765;
end

%%
function [y, no, tab] = newton (x0)

    for i = 1 : 10000
        fold=fun(x0);
        fpold=dfun(x0);
        dx = fold / fpold;
        x0 = x0 - dx;    
        if ( abs(fun(x0)) < 10^-8 )           
            y=x0;
            no=i;
            tab=0;
            return
        end
    end

    disp('Osiagnieta maksymalna liczba iteracji') 
    y = x0; 
    tab = 0;
end
