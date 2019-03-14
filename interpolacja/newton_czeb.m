%%
hold on;
title('Interpolacja wielomianowa Newtona z zastosowaniem wêz³ów Czebyszewa dla funkcji zadanej w zadaniu');
xlabel('x');
ylabel('f(x)');
grid on;
grid minor;
samples=linspace(-1,1,1111);

points_x=chebyshev(5);
points_x=sort(points_x);
points_y=getValues(points_x);
plot(samples, newton(samples, points_x, points_y), 'b');

points_x=chebyshev(9);
points_y=getValues(points_x);
plot(samples, newton(samples, points_x, points_y), 'k');

points_x=chebyshev(11);
points_y=getValues(points_x);
plot(samples, newton(samples, points_x, points_y), 'r');

points_x=chebyshev(15);
points_y=getValues(points_x);
plot(samples, newton(samples, points_x, points_y), 'c');

legend('5 wêz³ów', '9 wêz³ów', '11 wêz³ów', '15 wêz³ów');

hold off;

%%
function y = newton(x, points_x, points_y)
    n = size(points_x, 2);
    D = zeros(n,n);
    D(1:n,1)=points_y';
    for i=2:n
        for j=1:n+1-i
            D(j,i) = (D(j+1,i-1) - D(j,i-1))/(points_x(j+i-1)-points_x(j));
        end
    end
    r = D(1,:);
    p = r(n);
    for i=n-1:-1:1
        p = [p r(i)] - [0 p*points_x(i)];
    end
    y = polyval(p,x);
end
%%
function y = getValues(x)
    len=size(x,2);
    y=zeros(len,1);
    for i=1:size(x,2)
        y(i)=2/(2+x(i)^9)+1;
    end
    disp(size(x,2))
end
%%
function x = chebyshev(len)
    x=linspace(0,1,len);
    for i=1:len
        x(i) = cos(((2*i-1)*pi)/(2*len));
    end
end