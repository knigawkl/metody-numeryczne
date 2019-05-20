clc;
clear;
h=0.001;
start=0;
finish=10;
x0=0;
y0=1;
x=0:h:10;
point_count=length(x);

er=euler(h,x0,y0,point_count);
hr=heun(h,x0,y0,point_count);

f=@(x)(exp(-x)*cos(2*pi*x));
y=arrayfun(f, x);

plot(er(1, :), er(2, :), 'o', hr(1, :), hr(2, :), 'x', x, y);
grid on;
grid minor;
title('Porównanie rozwi¹zañ równania ró¿niczkowego');
legend('Wynik metody Eulera','Wynik metody Heuena','Wynik analityczny','location','best');
xlabel('x');
ylabel('f(x)');
ax=gca;
ax.XAxisLocation="origin";
ax.YAxisLocation="origin";
hold on;


%% euler's method
function euler_results = euler(h,x0,y0,point_count)
    euler_results=zeros(2,point_count);
    euler_results(:,1)=[x0;y0];
    for i=2:point_count
        x_prev=euler_results(1,i-1);
        y_prev=euler_results(2,i-1);
        x=x_prev+h;
        y=y_prev+h*fun(x_prev,y_prev);
        euler_results(:,i)=[x,y];
    end
end

%% heun's method
function heun_results = heun(h,x0,y0,point_count)
    heun_results=zeros(2,point_count);
    heun_results(:,1)=[x0;y0];
    for i=2:point_count
        x_prev=heun_results(1,i-1);
        y_prev=heun_results(2,i-1);
        x=x_prev+h;
        y=y_prev+h*(fun(x_prev,y_prev)+fun(x_prev+h,y_prev+h*fun(x_prev,y_prev)))/2;
        heun_results(:,i)=[x,y];
    end
end

%% util
function y = fun(x_p,y_p)
    y=-2*pi*exp(-x_p)*sin(2*pi*x_p) - y_p;
end