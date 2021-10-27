% Declaração do circuito RLC

R=1; %  Resistor de 1 Ohms
L=1*10^(-3); % Indultor de 1mH
C=150*10^(-6); % Capacitor de 150uF

% Sistema de espaço de estado
% x' = Ax + Bu
% y  = Cx + Du

A=[0 (1/C); (-1/L) (-R/L)];
B=[0; 1/L];
C=[1 0];
D=0;
sistema=ss(A,B,C,D);

% Verificando quais são os polos de malha aberta

eig(A);

% Verificando a controlabilidade do sistema 
% Posto da matriz

Controlabilidade=ctrb(A, B);
rank(Controlabilidade);

% Vetor de Ganho K para polos desejados

polos=[-2582 -2582];
K=acker(A,B,polos)

% Agora a verificação dos polos do sistema
% em malha fechada

eig(A-B*K);

% Novo Sistema de Malha Fechada

Amf=A-B*K;
Bmf=[0; 0];
Cmf=C;
Dmf=D;
sistemaMF=ss(Amf, Bmf, Cmf, Dmf);

% Condição Inicial

X0 = [10; 0];

% Tempo de Simulação

t=linspace(0, 0.02, 1000);

% Respostas de condição inicial

[YMA tplotMA]=initial(sistema, X0, t);
[YMF tplotMF]=initial(sistemaMF, X0, t);

figure;
subplot(2, 1, 1);
plot(t, YMA, 'linewidth', 2);
xlabel('t(s)');
ylabel('Vc(t)');
legend('Malha Aberta');
subplot(2, 1, 2);
plot(t, YMF, 'linewidth', 2);
xlabel('t(s)');
ylabel('Vc(t)');
legend('Malha Fechada');

