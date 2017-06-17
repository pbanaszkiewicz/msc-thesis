% Znajdź równania regulatora od zadanych wartości własnych układu zamkn.

%% regulator belki
syms lambda_1 lambda_2;
syms k_1 k_2 real;
ctrl = [k_1, k_2];
syms a real;
A_plant = [0 1; 0 a];
syms b real;
B_plant = [0; b];
M_closed_loop = A_plant - B_plant*ctrl;
[k_1_solution, k_2_solution] = solve(det(M_closed_loop) == lambda_1*lambda_2, ...
    trace(M_closed_loop) == lambda_1 + lambda_2, k_1, k_2);
clear k_1 k_2 A_plant B_plant M_closed_loop;
% c1 = charpoly(M);
% syms s;
% w = (s - lambda_1)*(s - lambda_2);
% w = expand(w);
% c2 = fliplr(coeffs(w,s));
% [k_1_solution_2, k_2_solution_2] = solve(c1 == c2, k_1, k_2)

%% podstawione wartości
Amp = 0.5 * 11.95;  % sygnał zadany
h_ss = 26.4230;  % wartość w stanie ustalonym
K_amp = h_ss / Amp;  % wzmocnienie obiektu
S_all = h_ss * 2;  % w przybliżeniu; pole całej figury prostokąta
S_under = 49.7287;  % całka z odpowiedzi skokowej
S_over = S_all - S_under;  % dopełnienie całki z odpowiedzi skokowej
T_const = S_over / h_ss;  % stała czasowa

% teoretyczny obiekt regulacji
A_plant = [0 1; 0 -1/T_const];
B_plant = [0; K_amp/T_const];

% wybrane wartości własne układu zamkniętego
lambda_1_des = -4.1189 * 2;
lambda_2_des = -13.7195 * 2.75;

% regulator
K_beam_des = [double(subs(k_1_solution, [lambda_1 lambda_2 a b], ...
                     [lambda_1_des lambda_2_des A_plant(4) B_plant(2)]))
              double(subs(k_2_solution, [lambda_1 lambda_2 a b], ...
                     [lambda_1_des lambda_2_des A_plant(4) B_plant(2)]))
              ];