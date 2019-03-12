%%
hold on;
title('Interpolacja wielomianowa Lagrange''a z zastosowaniem wêz³ów Czebyszewa dla funkcji zadanej w zadaniu');
xlabel('x');
ylabel('f(x)');
grid on;
grid minor;
samples=linspace(-1,1,1111);

points_x=chebyshev(5);
points_x=sort(points_x);
points_y=getValues(points_x);
plot(samples, lagrange(samples, points_x, points_y), 'b');
%{
points_x=chebyshev(9);
points_y=getValues(points_x);
plot(samples, lagrange(samples, points_x, points_y), 'k');

points_x=chebyshev(11);
points_y=getValues(points_x);
plot(samples, lagrange(samples, points_x, points_y), 'r');

points_x=chebyshev(15);
points_y=getValues(points_x);
plot(samples, lagrange(samples, points_x, points_y), 'c');

legend('5 wêz³ów', '9 wêz³ów', '11 wêz³ów', '15 wêz³ów');
%}
hold off;

%%
function y = lagrange(x, points_x, points_y)
    n=size(points_x, 2);
    L=ones(n, size(x, 2));
    for i=1:n
        for j=1:n
            if(i~=j)
                L(i,:)=L(i,:).*(x - points_x(j))/(points_x(i) - points_x(j));
            end
        end
    end
    y=0;
    for i=1:n
        y=y+points_y(i)*L(i,:);
    end
end
%%
function y = getValues(x)
    len=size(x,2);
    y=zeros(len,1);
    for i=1:size(x,1)
        y(i)=2/(2+x(i)^9)+1;
    end
end
%%
function x = chebyshev(len)
    x=linspace(0,1,len);
    for i=1:len
        x(i) = cos(((2*i+1)*pi)/(2*len+2));
    end
end