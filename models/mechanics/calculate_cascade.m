% calculate Cascade Control System
% continue from `optimize_bab_linearization.m`

linear_system_SS = S5;
linear_system_TF = G5;
clear G1 G2 G3 G4 G5 S1 S2 S3 S4 S5 T;

%% beam calculations

A_beam = linear_system_SS.A(3:4, 3:4);
B_beam = linear_system_SS.B(3:4);
C_beam = linear_system_SS.C(3:4, 3:4);
D_beam = 0;

beam_SS = ss(A_beam, B_beam, C_beam, D_beam);
beam_SS.InputName = {'voltage'};
beam_SS.OutputName = {'beam_angle'; 'beam_angular_velocity'};
beam_TF = tf(beam_SS);

% Find gain by placing poles
%P_beam = [-3 -10];
%K_beam = acker(A_beam, B_beam, P_beam);
%K_beam = place(A_beam, B_beam, P_beam);
%K_beam = [-8.207  -1.576];

% Find gain by tuning the loop
P_beam_tunable = tunableGain('K_beam', [1 1]);
[~, P_beam] = looptune(beam_SS, P_beam_tunable, 10);
% P_beam is a state space with only D matrix, which we need to extract the
% gain from it
P_beam = ss(-P_beam);
P_beam.InputName = {'beam_angle_error'; 'beam_angular_velocity_error'};
P_beam.OutputName = {'voltage'};
K_beam = get(P_beam, 'D');

% sum block in the internal loop
sum_inter = sumblk('%v = %s - %y', ...
    {'beam_angle_error', 'beam_angular_velocity_error'}, ...
    {'alpha_ref'; 'omega_ref'}, ...
    {'beam_angle'; 'beam_angular_velocity'});

% let's make a connected system
beam_collapsed = connect(P_beam, beam_SS, sum_inter, ...
    {'alpha_ref'; 'omega_ref'}, {'beam_angle'; 'beam_angular_velocity'});
beam_collapsed_TF = tf(beam_collapsed);
%bode(beam_collapsed(1,1));
step(beam_collapsed);

clear P_beam_tunable

%% ball calculations

A_ball = linear_system_SS.A(1:2, 1:2);
B_ball = linear_system_SS.A(1:2, 3:4);
C_ball = linear_system_SS.C(1:2, 1:2);
D_ball = linear_system_SS.C(1:2, 3:4);
% C_ball = [linear_system_SS.C(1:2, 1:2); zeros(2)];
% D_ball = [linear_system_SS.C(1:2, 3:4); eye(2)];

ball_SS = ss(A_ball, B_ball, C_ball, D_ball);
ball_SS.InputName = {'beam_angle'; 'beam_angular_velocity'};
ball_SS.OutputName = {'ball_position'; 'ball_velocity'};
% ball_SS.OutputName = {'ball_position'; 'ball_velocity'; 'beam_angle'; 'beam_angular_velocity'};
ball_TF = tf(ball_SS);

% add to the connected system
collapsed_beam_ball = connect(beam_collapsed, ball_SS, ...
    {'alpha_ref'; 'omega_ref'}, ...
    {'ball_position'; 'ball_velocity'; 'beam_angle'; 'beam_angular_velocity'});

% Find gain by tuning the loop
P_ball_tunable = tunableGain('K_ball', [1 0 0 0; 0 1 0 0;]);
P_ball_tunable.InputName = {'ball_position'; 'ball_velocity'; 'beam_angle'; 'beam_angular_velocity'};
P_ball_tunable.OutputName = {'alpha_ref'; 'omega_ref'};
[~, P_ball, gam, info] = looptune(collapsed_beam_ball, P_ball_tunable, 100);
P_ball = ss(-P_ball);
P_ball.InputName = {'pos_error'; 'vel_error'; 'angle_error'; 'ang_velo_error'};
K_ball = get(P_ball, 'D');

% sum block in the external loop
sum_outer = sumblk('%v = %s - %y', ...
    {'pos_error'; 'vel_error'; 'angle_error'; 'ang_velo_error'}, ...
    {'position_ref', 'velocity_ref', 'angle_ref', 'angular_velocity_ref'}, ...
    {'ball_position'; 'ball_velocity'; 'beam_angle'; 'beam_angular_velocity'});

% collapse
%P_ball.D = [2 1 0 0; 1 0 0 0]; nie to nie daje
%P_ball.D = [3.8804    0.1733    4.6754    3.0000;
%    0.7450    0.0333    0.8976    0.5760];
P_ball.D(4) = 0.2;
collapsed = connect(P_ball, collapsed_beam_ball, sum_outer, ...
    {'position_ref', 'velocity_ref', 'angle_ref', 'angular_velocity_ref'}, ...
    {'ball_position'; 'ball_velocity'; 'beam_angle'; 'beam_angular_velocity'});