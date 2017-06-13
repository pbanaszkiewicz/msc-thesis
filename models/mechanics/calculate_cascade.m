% calculate Cascade Control System
% continue from `optimize_bab_linearization.m`

%% beam calculations

A_beam = S5.A(3:4, 3:4);
B_beam = S5.B(3:4);
C_beam = S5.C(3:4, 3:4);
D_beam = 0;

beam_SS = ss(A_beam, B_beam, C_beam, D_beam);
beam_TF = tf(beam_SS);

%P_beam = [-3 -10];
%K_beam = acker(A_beam, B_beam, P_beam);
%K_beam = place(A_beam, B_beam, P_beam);
%K_beam = [-8.207  -1.576];


P_beam = tunableGain('K_beam', [1 1]);
[~, P_beam, gam, info] = looptune(beam_SS, P_beam, 10);
K_beam = get(ss(P_beam), 'D');
fb = feedback(beam_SS, K_beam, +1);
bode(fb(1,1));
%step(feedback(beam_SS, K_beam, +1));
%closed_loop = feedback(beam_SS, K_beam, +1);
%figure(1);
%step(closed_loop);