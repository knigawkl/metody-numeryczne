hold on;
title('Interpolacja wielomianowa Newtona z zastosowaniem wêz³ów równoodleg³ych dla funkcji zadanej w zadaniu');
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

legend('5 wêz³ów', '9 wêz³ów', '11 wêz³ów', '15 wêz³ów');

hold off;

%%
X=linspace(-1,1,1111);
Y=getValues(X);
points_x=splitInterval(5);
points_y=getValues(points_x);
intY=newton(X, points_x, points_y);
D=abs(Y'-intY);
m5=max(D);
a5=mean(D);

points_x=splitInterval(9);
points_y=getValues(points_x);
intY=newton(X, points_x, points_y);
D=abs(Y'-intY);
m9=max(D);
a9=mean(D);

points_x=splitInterval(11);
points_y=getValues(points_x);
intY=newton(X, points_x, points_y);
D=abs(Y'-intY);
m11=max(D);
a11=mean(D);

points_x=splitInterval(15);
points_y=getValues(points_x);
intY=newton(X, points_x, points_y);
D=abs(Y'-intY);
m15=max(D);
a15=mean(D);

sprintf("%g %g \n %g %g \n %g %g \n %g %g \n",m5, a5, m9, a9, m11, a11, m15, a15)
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