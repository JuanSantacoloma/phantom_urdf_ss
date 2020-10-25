rosshutdown;
rosinit;

pause(10)

mover([0 0 0 0])
mover([ -20 20 -20 20])
mover([ 30 -30 30 -30])
mover([ 30 -30 30 -30])
mover([ -90 15 -55 17])
pause(1)
mover([ -90 45 -55 45])
pause(1)
mover([0 0 0 0])

function mover(a)
disp(a)


% Robot Phantom
q1=0; q2=0; q3=0; q4=0;
% Conformacionn de los eslabones

phan(1) = Link('revolute', 'alpha',0,    'a',0,     'd', 137/100,'offset', -pi/2, 'modified');
phan(2) = Link('revolute', 'alpha',-pi/2,'a',0,       'd', 0,'offset', -pi/2, 'modified');
phan(3) = Link('revolute', 'alpha',0,    'a',105/100, 'd', 0,'offset', 0, 'modified');
phan(4) = Link('revolute', 'alpha',0,    'a',105/100, 'd', 0,'offset', 0, 'modified');

phantom = SerialLink(phan,'name','Phatom X');
phantom.tool = troty(90,'deg')*transl(0,0,95/100);
figure(1)
q=[0,0,0,0];
phantom.plot(q,'workspace',[-1 3 -2 2 -2 6],'noa','view',[-20.35 27.86])

waistPub = rospublisher('/joint1_position_controller/command', ...
    'std_msgs/Float64'); %Creación del publicador
waistMsg = rosmessage(waistPub); %Creación del mensaje


shoulderPub = rospublisher('/joint2_position_controller/command', ...
    'std_msgs/Float64'); %Creación del publicador
shoulderMsg = rosmessage(shoulderPub); %Creación del mensaje


elbowPub = rospublisher('/joint3_position_controller/command', ...
    'std_msgs/Float64'); %Creación del publicador
elbowMsg = rosmessage(elbowPub); %Creación del mensaje


wristPub = rospublisher('/joint4_position_controller/command', ...
    'std_msgs/Float64'); %Creación del publicador
wristMsg = rosmessage(wristPub); %Creación del mensaje


handPub = rospublisher('/joint5_position_controller/command', ...
    'std_msgs/Float64'); %Creación del publicador
handMsg = rosmessage(handPub); %Creación del mensaje


if a(1)<150&&a(1)>-150
waistMsg.Data = 0 + deg2rad(a(1));  %Envío de datos a partir de Home con límite de los motores
end
if a(1)<150&&a(1)>-150
shoulderMsg.Data = 0 + deg2rad(a(2));
end
if a(1)<150&&a(1)>-150
elbowMsg.Data = 0 + deg2rad(a(3));
end
if a(1)<150&&a(1)>-150
wristMsg.Data = 0 + deg2rad(a(4));
end
% if a(1)<150&&a(1)>-150
% handMsg.Data = 0 + deg2rad(a(5));
% end

phantom.animate([ deg2rad(a(1)) deg2rad(a(2)) deg2rad(a(3)) deg2rad(a(4)) ])
send(waistPub,waistMsg); %Envio
send(shoulderPub,shoulderMsg); %Envio
send(elbowPub,elbowMsg); %Envio
send(wristPub,wristMsg); %Envio
send(handPub,handMsg); %Envio

pause(2)
end




