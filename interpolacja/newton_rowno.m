hold on;
title('Interpolacja wielomianowa Newtona z zastosowaniem w�z��w r�wnoodleg�ych dla funkcji zadanej w zadaniu');
xlabel('x');
ylabel('f(x)');
grid on;
grid minor;
samples=linspace(-1,1,1111);

points_x=splitInterval(5);
points_y=getValues(points_x);
plot(samples, newton(samples, points_x, points_y), 'b');

points_x=splitInterval(9);
points_y=getValues(points_x);
plot(samples, newton(samples, points_x, points_y), 'k');

points_x=splitInterval(11);
points_y=getValues(points_x);
plot(samples, newton(samples, points_x, points_y), 'r');

points_x=splitInterval(15);
points_y=getValues(points_x);
plot(samples, newton(samples, points_x, points_y), 'c');

legend('5 w�z��w', '9 w�z��w', '11 w�z��w', '15 w�z��w');

hold off;

%%
function x = splitInterval(node_count)
    x=linspace(-1,1,node_count);
end
%%
function y = getValues(x)
    len=size(x,2);
    y=zeros(len,1);
    for i=1:size(x,2)
        y(i)=2/(2+x(i)^9)+1;
    end
end
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