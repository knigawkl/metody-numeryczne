clear all
s = importdata('dane_apx1.mat');
% Wczytanie X,Y
x = s(:,1);
y = s(:,2);

%Obliczenie dla funkcji a0+a1x+a2e^-x 
A = [ length(x),     sum(x),          sum(exp(-x));
      sum(x),        sum(x.*x),       sum(x.*exp(-x));
      sum(exp(-x)),  sum(x.*exp(-x)), sum(exp(-x).*exp(-x))];
  
b = [ sum(y);
      sum(y.*x);
      sum(y.*exp(-x))];
  
a=A\b

%wyswietlenie punktow
figure, plot([0 10],[0 10],'w')
hold on
for k=1:length(x)
    plot(x(k),y(k),'r+')
end

%obliczenie wspó³rzêdnych
wykresx = 0:0.1:10;
wykresy = a(1)+a(2).*wykresx+a(3).*exp(-wykresx);

%wyœwietlenie
plot(wykresx,wykresy,'b')

hold off

%wsp uwarunkowania
condA = cond(A)

%funkcja celu
I = sum( (y-(a(1)+a(2).*x+a(3).*exp(-x))).^2 )