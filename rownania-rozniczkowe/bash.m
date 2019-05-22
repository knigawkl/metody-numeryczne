clear;
h=0.001;
start=0;
finish=10;
t0=0;
x0=0;
v0=1;
t=0:h:10;
point_count=length(t);

b2=abash(h,t0,x0,v0,point_count, 2);
b3=abash(h,t0,x0,v0,point_count, 3);

f=@(x)(sin(x));
y=arrayfun(f, t);

plot(b2(1, :), b2(2, :), 'o', b3(1, :), b3(2, :), 'x', t, y);
grid on;
grid minor;
title('Porównanie rozwi¹zañ uk³adu równañ ró¿niczkowych');
legend('Wynik Adamsa-Bashfortha 2 rzêdu','Wynik Adamsa-Bashfortha 3 rzêdu','Wynik analityczny','location','best');
xlabel('x');
ylabel('f(x)');
ax=gca;
ax.XAxisLocation="origin";
ax.YAxisLocation="origin";
hold on;

%% errors
er_err=abs(y-b2(2, :));
max_er_err=max(er_err);
hr_err=abs(y-b3(2,:));
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

%% adams-bash
function bash_results = abash(h,t0,x0,v0,point_count,step) %specjalna dedykacja dla ATO
    bash_results=zeros(3,point_count);
    bash_results(:,1)=[t0;x0;v0];
    for i=2:step
        t_prev=bash_results(1,i-1);
        x_prev=bash_results(2,i-1);
        v_prev=bash_results(3,i-1);
        t=t_prev+h;
        x=x_prev+h*v_prev;
        v=v_prev+h*(-x_prev);
        bash_results(:,i)=[t,x,v];
    end
    
    for i=step+1:point_count 
        t_prev=bash_results(1,i-1);
        x_prev=bash_results(2,i-1);
        v_prev=bash_results(3,i-1);
        t=t_prev+h;
        if step == 2
            x=x_prev+h*(3/2*bash_results(2,i-1)+(-1/2)*bash_results(2,i-2));
            v=v_prev+h*(3/2*bash_results(3,i-1)+(-1/2)*bash_results(2,i-2));
        end
        if step == 3
            x=x_prev+h*(23/12*bash_results(2,i-1)+(-16/12)*bash_results(2,i-2)+5/12*bash_results(2,i-3));
            v=v_prev+h*(23/12*bash_results(3,i-1)+(-16/12)*bash_results(3,i-2)+5/12*bash_results(3,i-3));
        end
        bash_results(:,i)=[t,x,v];    
    end                   
end