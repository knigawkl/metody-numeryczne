clc;
clear;
h=0.001;
start=0;
finish=10;
t0=0;
x0=0;
v0=1;
t=0:h:10;
point_count=length(t);

er=euler(h,t0,x0,v0,point_count);
hr=heun(h,t0,x0,v0,point_count);

f=@(x)(sin(x));
y=arrayfun(f, t);

plot(er(1, :), er(2, :), 'o', hr(1, :), hr(2, :), 'x', t, y);
grid on;
grid minor;
title('Porównanie rozwi¹zañ uk³adu równañ ró¿niczkowych');
legend('Wynik metody Eulera','Wynik metody Heuena','Wynik analityczny','location','best');
xlabel('x');
ylabel('f(x)');
ax=gca;
ax.XAxisLocation="origin";
ax.YAxisLocation="origin";
hold on;

%% errors
er_err=abs(y-er(2, :));
max_er_err=max(er_err);
hr_err=abs(y-hr(2,:));
max_hr_err= max(hr_err);

%% euler's method
function euler_results = euler(h,t0,x0,v0,point_count)
    euler_results=zeros(3,point_count);
    euler_results(:,1)=[t0;x0;v0];
    for i=2:point_count
        t_prev=euler_results(1,i-1);
        x_prev=euler_results(2,i-1);
        v_prev=euler_results(3,i-1);
        t=t_prev+h;
        x=x_prev+h*v_prev;
        v=v_prev+h*(-x_prev);
        euler_results(:,i)=[t,x,v];
    end
end

%% heun's method
function heun_results = heun(h,t0,x0,v0,point_count)
    heun_results=zeros(3,point_count);
    heun_results(:,1)=[t0;x0;v0];
    dxdt = @(x, y) (y);
    dvdt = @(x, y) (-x);   
    for i=2:point_count
        t_prev=heun_results(1,i-1);
        x_prev=heun_results(2,i-1);
        v_prev=heun_results(3,i-1);
        t=t_prev+h;
        x=x_prev+h*(dxdt(x_prev, v_prev) + dxdt(x_prev+h, v_prev+h*dxdt(x_prev, v_prev)))/2;
        v=v_prev+h*(dvdt(x_prev, v_prev) + dvdt(x_prev+h, v_prev+h*dvdt(x_prev, v_prev)))/2;        
        heun_results(:,i)=[t,x,v];
    end
end
