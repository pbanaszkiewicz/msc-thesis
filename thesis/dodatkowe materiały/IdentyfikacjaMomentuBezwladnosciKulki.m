% Identyfikacja momentu bezwładności kulki na podstawie wyników
% doświadczenia, w którym kulka swobodnie stacza się po pochylonej belce.

% efektywny promień kulki
syms r_e positive

% kąt pochylenia belki
syms alpha positive
assumeAlso(alpha < pi/2)

% masa kulki
syms m positive

% moment bezwładności kulki
syms J positive

% przyspieszenie ziemskie
syms g positive

% siła cięzkości (przyłożona do środka masy kulki)
G = m*g;

% składowa styczna siły ciężkości (równoległa do powierzchni belki)
G_tau = G*sin(alpha);

% siła rekacji podłoża (przyłożona do kulki w punkcie styczności kulki z belką)
% syms R positive

% składowa styczna siły reakcji podłoża (tarcie suche przy toczeniu bez poślizgu)
syms R_tau positive

% położenie liniowe środka masy kulki (mierzone wzdłuż belki, od położenia początkowego/spoczynkowego w dół)
syms x real

% położenie kątowe kulki (kąt obrotu kulki sposowodany toczeniem)
syms fi real

% przyspieszenie liniowe środka masy kulki
syms a real

% przyspieszenie kątowe kulki
% syms epsilon

% zależność między przyspieszeniami: liniowym i kątowym kulki
epsilon = a / r_e;

% równania z drugiej zasady dynamiki Newtona dla ruchu postępowego środka
% masy kulki i ruchu obrotowego wokół tegoż środka masy
% m * a == G_tau - R_tau
% J * epsilon == R_tau * r_e
[a, R_tau] = solve (a * m == G_tau - R_tau, epsilon * J == R_tau * r_e, a, R_tau)

% czas swobodnego staczania (od t_0 = 0, v_0 = 0, x_0 = 0)
syms dt positive
% Delta_t = t_1 - t_0

% droga przebyta w czasie Delta_t
syms dx positive
% Delta_x = x_1 - x_0,   x_1 = x(t_1)

% równanie dla ruchu jednostajnie przyspieszonego
% Delta_x == 1/2*a*Delta_t^2
J = solve(dx == 1/2*a*dt^2, J)
J = simplify(J)

% uzyskany wynik
pretty(J)
