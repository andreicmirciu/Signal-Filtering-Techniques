% Mirciu Andrei-Constantin 323CD
t = -10:0.01:10;
k = 100;
u = cos(100 * t + pi / 3); % semnal de intrare
h = exp(-k * t); % functie pondere stabila
% in functie de k, semnalul se atenueaza mai repede sau mai incet
y = conv(h,u); % filtrarea semnalului u si obtinerea semnalului de iesire
% semnalul de iesire y are lungimea 4001
d1 = angle(u); 
% u are valorile amplitudinii intre -1 si 1
% cu cat creste valoarea lui k, se mareste si valoarea amplitudinii
% semnalului de iesire
d2 = angle(y);
% atat defazajul semnalului de intrare, cat si cel al semnalului de iesire
% variaza intre valorile 3,1416 sau 0
%----------------------------------
subplot(2,1,1);
plot(t,u); 
title('Semnalul de intrare u ');
subplot(2,1,2);
plot(y); 
title('Semnalul de iesire y ');
