%% Laboratorio 4
% Hecho por: Juan Santacoloma
%            Manuela Sucerquia

%% Inversa Peter Corke
clear all
clc
% Longitudes
l1 = (137-0)/100;
l2 = 105/100;
l3 = 105/100;
l4 = 95/100;

q_objetivo = [215/100;0/100;200/100;pi/3];
% q_objetivo = [215/100;0/100;200/100;0];

% Conformacionn de los eslabones

% phan(1) = Link('revolute', 'alpha',0,    'a',0,      'd', 137/100,'offset', -pi/2, 'modified','qlim',[-pi pi]);
% phan(2) = Link('revolute', 'alpha',-pi/2,'a',0,      'd', 0,      'offset', -pi/2, 'modified','qlim',[-pi pi]);
% phan(3) = Link('revolute', 'alpha',0,    'a',105/100,'d', 0,      'offset', 0, 'modified','qlim',[-pi pi]);
% phan(4) = Link('revolute', 'alpha',0,    'a',105/100,'d', 0,      'offset', 0, 'modified','qlim',[-pi pi]);

phan(1) = Link('revolute', 'alpha',0,    'a',0,      'd', l1,'offset', -pi/2, 'modified');
phan(2) = Link('revolute', 'alpha',-pi/2,'a',0,      'd', 0,      'offset', -pi/2, 'modified');
phan(3) = Link('revolute', 'alpha',0,    'a',l2,'d', 0,      'offset', 0, 'modified');
phan(4) = Link('revolute', 'alpha',0,    'a',l3,'d', 0,      'offset', 0, 'modified');

% phan(1) = Link('revolute', 'alpha',pi/2, 'a',0,       'd', 137/100,'offset', 0, 'modified');
% phan(2) = Link('revolute', 'alpha',0,    'a',105/100, 'd', 0,'offset', pi/2, 'modified');
% phan(3) = Link('revolute', 'alpha',0,    'a',105/100, 'd', 0,'offset', 0, 'modified');
% phan(4) = Link('revolute', 'alpha',0,    'a',105/100, 'd', 0,'offset', 0, 'modified');

phantom = SerialLink(phan,'name','Phatom X');
phantom.base = trotz(90,'deg')*transl(0,0,0);
phantom.tool = troty(90,'deg')*transl(0,0,l4);

%% Cinematica Inversa Phantom

% Posicion del TCP
q_objetivo = [215/100;0/100;200/100;pi/3];
% q_objetivo = [215/100;0/100;200/100;0];
tool_inv = [roty(0)', -roty(0)'*[0;0;l4];[0,0,0,1]];
Tqobj = transl(q_objetivo(1),q_objetivo(2),q_objetivo(3))*troty(q_objetivo(4));
% Tq3 = Tqobj*tool_inv;
% 
% x = Tq3(1,4);
% y = Tq3(2,4);
% z = Tq3(3,4);
% alpha = q_objetivo(4);

[q1,q2,q3,q4] = invPhantom(Tqobj)
ikinematics_lab4 = [q1,q2,q3,q4]

%% Graficas inversa Toolbox
figure(1)
ws = [-5 5 -5 5 -1 5];
% Base
trplot(eye(4),'rgb','length',1,'frame','B')
hold on
% Punto en q3
q3_point = transl(q_objetivo(1),q_objetivo(2),q_objetivo(3))*troty(q_objetivo(4));
trplot(q3_point ,'rgb','length',1,'frame','obj')
% Punto Objetivo
p_objetivo = transl(q_objetivo(1),q_objetivo(2),q_objetivo(3))*troty(q_objetivo(4));
trplot(p_objetivo,'rgb','length',1)
% Inverse Kinematics
[q_ikunk,err,exitflag] = phantom.ikunc(p_objetivo,[0,0,0,0])
% Robot plot
phantom.plot(q_ikunk,'notiles','scale',1,'jaxes')
axis(ws)

%% Verificacion inversa geometrico SS
figure(2)
ws = [-5 5 -5 5 -1 5];
% Base
trplot(eye(4),'rgb','length',1,'frame','B')
hold on
% Punto Objetivo
p_objetivo = transl(q_objetivo(1),q_objetivo(2),q_objetivo(3))*troty(q_objetivo(4));
trplot(p_objetivo,'rgb','length',1,'frame','obj')
% Robot plot
phantom.plot(ikinematics_lab4,'notiles','scale',1,'jaxes')
axis(ws)

hold off
%% Mover phatom URDF

