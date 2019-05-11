x = [-1 2 3 6];
y = [1 2 3 5];
n = 3;
A = [];
b = [];
for r = 1:n  
    for c = 1:n  
        A(c,r) = sum(x.^(r+c-2));  
    end
    b(r) = sum(y.*(x.^(r-1))); 
end
 a=A\b';
 xd = linspace(min(x), max(x), 100);
 yd = zeros(size(xd)); 
 for i = 1:n 
     yd = yd + a(i) * xd.^(i-1); 
 end
 S = zeros(size(x));
 for i = 1:size(x) 
    for j = 1:n 
        S(i) = S(i) + a(j)*x(i)^(j-1);        
    end
    S(i) = (S(i) - y(i))^2;
 end
 sum(S)/n
 plot(x,y,'o', xd, yd);