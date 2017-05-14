% Ładujemy wyniki linearyzacji modelu zapisanego w Simulinku
% i SimMechaniksie.
load lin_analysis_session
S1 = LinearAnalysisToolProject.Results.Data.Value
% Upewniamy się, że macierz wyjścia jest diagonalna.
assert(max(max(abs(S1.c - diag(diag(S1.c)))))<eps)
S1.c = diag(diag(S1.c))
G1 = tf(S1)

%%
% Transformujemy równania stanu by uzyskać jednostkową macierz wyjścia.
S2 = ss2ss(S1,S1.c)
% Upewniamy się, że macierz wyjścia jest jednostkowa.
assert(max(max(abs(S2.c - eye(4)))) < 1e-10)
S2.c = eye(4)
k = find(S1.a == 0)
% Upewniamy się, że elementy macierzy stanu, które zerowały się poprzednio,
% zerują się i teraz.
assert(max(abs(S2.a(k)))<1e-15)
S2.a(k) = 0;
k = find(S1.a == 1)
% Upewniamy się, że elementy macierzy stanu, które były jednostkowe
% poprzednio, są jednostkowe i teraz.
assert(max(abs(S2.a(k) - 1))<1e-6)
S2.a(k) = 1;
G2 = tf(S2)

%%
% Próbujemy uprościć równania stanu by uzyskać blokowo trójkątną górna
% macierz stanu oraz zerowy górny blok macierzy wejścia.
S3 = S2
S3.a(4) = 0
S3.b(2) = 0
assert(all(S3.b(1:2)==0))
assert(all(S3.a([3:4,7:8])==0))
G3 = tf(S3)

%%
% Porównujemy odpowiedzi (czasowe i częstotliwościowe) systemu przed i po
% uproszczeniu.
figure
step(S2, S3, 0:0.001:5)
figure
bode(S2(1,1), S3(1,1), {1e-2,1e2})

%%
% Transformujemy równania stanu by uzyskać zeranie górnego blok w macierzy
% wejścia.
T = [eye(2), -S2.b(2)/S2.b(4)*eye(2); zeros(2), eye(2)]
S4 = ss2ss(S2,T)
k = 1:3
% Upewniamy się, że odpowiednie elementy macierzy wejścia są zerowe.
assert(max(abs(S4.b(k)))<1e-15)
S4.b(k) = 0
k = [2,14]
% Upewniamy się, ze wybrane elementy macierzy stanu są zerowe.
assert(max(abs(S4.a(k)))<1e-10)
S4.a(k) = 0
G4 = tf(S4)

%%
% Upraszczamy równania stanu by uzyskać uzyskać blokowo trójkątną górna
% macierz stanu.
S5 = S4
S5.a([4,1]) = 0
G5 = tf(S5)

%%
% Porównujemy odpowiedzi (czasowe i częstotliwościowe) systemu przed i po
% uproszczeniu.
figure
step(S4, S5, 0:0.001:5)
figure
bode(S4(1,1), S5(1,1), {1e-2, 1e7})
