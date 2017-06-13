%% trim and linearize the model
%trim_bab;
%linearize_bab;
load 'bab_lin3.mat'
S1 = linsys1;
%clear linsys operating_point_report;

%% ensure output matrix is diagonal or close to diagonal
assert(is_diagonal(S1.c, eps));
S1.c = diag(diag(S1.c));  % remove elements other than diagonal
G1 = tf(S1);
%clear m;

%% convert state space system to achieve identity output matrix
% transform state space by it's output matrix C (this gives identity output
% matrix)
S2 = ss2ss(S1, S1.c);

% make sure new output matrix (S2.C) is diagonal
assert(is_diagonal(S2.c, 1e-10));
S2.c = diag(diag(S2.c));

% ensure zero'd elements from S1.A are still zero'd in S2.A
k = find(S1.a == 0);
assert(all(abs(S2.a(k))) < 1e-15);
S2.a(k) = 0;

% similarly ensure ones are in the same places as they were in S1.A
k = find(S1.a == 1);
assert(all(abs(S2.a(k) - 1) < 1e-6));
S2.a(k) = 1;
G2 = tf(S2);
clear k;

%% try to simplify state equations to achieve an upper triangular matrix
S3 = S2;
% upper triangular matrix
S3.a(4) = 0;
% zero'd upper half of input matrix B
S3.b(2) = 0;

% ensure all required elements are zero'd
assert(all(S3.b(1 : 2) == 0));
assert(all(S3.a([3 : 4, 7 : 8]) == 0));
G3 = tf(S3);

%% compare system step and frequency responses
figure(1);
step(S2, S3, 0 : 0.001 : 5);
figure(2);
bode(S2(1, 1), S3(1, 1), {1e-2, 1e2});

%% use a different transformation matrix
% compensate reverse ball rotating motion caused by positive angular
% acceleration of the beam
T = [eye(2), -S2.b(2) / S2.b(4) * eye(2); zeros(2), eye(2)];
S4 = ss2ss(S2, T);

% ensure only one element of the input matrix is non-zero
k = 1:3;
assert(all(abs(S4.b(k)) < 1e-15));
S4.b(k) = 0;

% ensure specific state matrix elements are zero'd
k = [2 14];
assert(all(abs(S4.a(k)) < 1e-12));
S4.a(k) = 0;
G4 = tf(S4);

clear k;

%% simplify state space by making state matrix upper triangular
% Upraszczamy równania stanu by uzyskać uzyskać blokowo trójkątną górna
% macierz stanu.
S5 = S4;
S5.a([4, 1]) = 0;
G5 = tf(S5);

%% compare system step and frequency responses
figure(3);
step(S4, S5, 0 : 0.001 : 5);
figure(4);
bode(S4(1, 1), S5(1, 1), {1e-2, 1e7});
