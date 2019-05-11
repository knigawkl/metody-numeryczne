%% newton prosty test
fi=11;
h=0.5;
newtonpr(fi,h)
fi=[0,11];
h=1;
newtonpr(fi,h)
fi=[0, 0.0107, 11];
h=0.5;
newtonpr(fi,h)
fi=[0, 0.000186, 0.1907, 11];
h=0.333;
newtonpr(fi,h)
fi=[0, 0.00001, 0.0107, 0.61945, 11];
h=0.25;
newtonpr(fi,h)
fi=[11,0.0107421875,0,0.0107421875,11];
h=0.5;
newtonpr(fi,h)

%% newton z³o¿ony obl

xpoints=-1:0.01:1;
ypoints=fun(xpoints);
newtonzl(ypoints, 0.01, 1)
newtonzl(ypoints, 0.01, 2)
newtonzl(ypoints, 0.01, 3)
newtonzl(ypoints, 0.01, 4)

%% newton prosty
function y = newtonpr(fi, h)
    if size(fi, 2) == 1
        y=h*fi(1);
    elseif size(fi, 2) == 2
        y=h/2*(fi(1)+fi(2));
    elseif size(fi, 2) == 3
        y=h/3*(fi(1)+4*fi(2)+fi(3));
    elseif size(fi, 2) == 4
        y=3*h/8*(fi(1)+3*fi(2)+3*fi(3)+fi(4));
    elseif size(fi, 2) == 5
        y=2*h/45*(7*fi(1)+32*fi(2)+12*fi(3)+32*fi(4)+7*fi(5));
    else
        y=NaN;
    end   
end

%% newton z³o¿ony
function y = newtonzl(fi, h, d)
    i=size(fi, 2);
    y=0;
    while i > d
        v=fi(size(fi,2)-i+1);
        l=1;
        while l <= d
           v=[v fi(size(fi,2)-i+1+l)];
           l=l+1;
        end
        y=y+newtonpr(v,h);
        i=i-d;
    end
    if i ~= 0
        v=[];
       while i > 0
          v=[v fi(size(fi,2)-i+1)];
          i=i-1;
       end
       y=y+newtonpr(v,h); 
    end
    
end

%% funkcja zadana

function y = fun(x)
y = 11*x.^10;
end