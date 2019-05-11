clear;
[ret, no, tab] = bisection(-1,1);
x=linspace(-1,1,1000);
y=zeros(1,1000);
for i=1:1000
    y(i)=fun(x(i));
end
plot(x, y, ret, fun(ret), 'o');
grid on;
grid minor;
title('Rozwi¹zanie równania nieliniowego metod¹ bisekcji');
xlabel('x');
ylabel('f(x)');
hold on;

%%
function f=fun(x)
    f = 3.55*x^3 - 1.1*x^2 - 0.765*x + 0.74;
end

%%
function [ret, no, tab] = bisection (xl, xr)
    n=10000;
    for i=1:n
        xm=xl+(xr-xl)/2;
        ym=fun(xm);
        if ( abs(fun(xm)) < 10^-8 )           
            ret=xm;
            no=i;
            tab=0;
            return
        end
        if ym*fun(xl)>0
            xl=xm;
        else
            xr=xm;
        end
    end

    disp('Osiagnieta maksymalna liczba iteracji') 
    ret = xm; 
    tab = 0;
end