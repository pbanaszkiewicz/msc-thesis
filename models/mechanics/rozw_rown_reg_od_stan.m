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
C_plant = eye(2);
D_plant = zeros(2, 1);
beam_SS2 = ss(A_plant, B_plant, C_plant, D_plant);
beam_SS2.InputName = {'voltage'};
beam_SS2.OutputName = {'beam_angle'; 'beam_angular_velocity'};

% wybrane wartości własne układu zamkniętego
lambda_1_des = -4.1189 * 2;
lambda_2_des = -13.7195 * 2.75;

% regulator
K_beam_des = [double(subs(k_1_solution, [lambda_1 lambda_2 a b], ...
                     [lambda_1_des lambda_2_des A_plant(4) B_plant(2)]))
              double(subs(k_2_solution, [lambda_1 lambda_2 a b], ...
                     [lambda_1_des lambda_2_des A_plant(4) B_plant(2)]))
              ]';

%% oblicz nowe pętle
P_beam2 = ss(tunableGain('K_beam', K_beam_des));
P_beam2.InputName = {'beam_angle_error'; 'beam_angular_velocity_error'};
P_beam2.OutputName = {'voltage'};
K_beam2 = get(P_beam2, 'D');

beam_collapsed2 = connect(P_beam2, beam_SS2, sum_inter, ...
    {'alpha_ref'; 'omega_ref'}, {'beam_angle'; 'beam_angular_velocity'});
beam_collapsed2_TF = tf(beam_collapsed2);

collapsed_beam_ball2 = connect(beam_collapsed2, ball_SS, ...
    {'alpha_ref'; 'omega_ref'}, ...
    {'ball_position'; 'ball_velocity'; 'beam_angle'; 'beam_angular_velocity'});

P_ball_tunable2 = tunableGain('K_ball2', [1 0 0 0; 0 1 0 0;]);
P_ball_tunable2.InputName = {'ball_position'; 'ball_velocity'; 'beam_angle'; 'beam_angular_velocity'};
P_ball_tunable2.OutputName = {'alpha_ref'; 'omega_ref'};
[~, P_ball2] = looptune(collapsed_beam_ball2, P_ball_tunable2, 1);
P_ball2 = ss(-P_ball2);
P_ball2.InputName = {'pos_error'; 'vel_error'; 'angle_error'; 'ang_velo_error'};
K_ball2 = get(P_ball2, 'D');

collapsed2 = connect(P_ball, collapsed_beam_ball2, sum_outer, ...
    {'position_ref', 'velocity_ref', 'angle_ref', 'angular_velocity_ref'}, ...
    {'ball_position'; 'ball_velocity'; 'beam_angle'; 'beam_angular_velocity'});