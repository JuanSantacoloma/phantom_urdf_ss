rosshutdown;
rosinit;

waistSub = rossubscriber('/joint1_position_controller/command', ...
    'std_msgs/Float64'); %Creación de suscriptor al tópico
pause(1)
waistData = waistSub.LatestMessage;
disp(waistData)


shoulderSub = rossubscriber('/joint2_position_controller/command', ...
    'std_msgs/Float64'); %Creación de suscriptor al tópico
pause(1)
shoulderData = shoulderSub.LatestMessage;
disp(shoulderData)
% 
% 
elbowSub = rossubscriber('/joint3_position_controller/command', ...
    'std_msgs/Float64'); %Creación de suscriptor al tópico
pause(1)
elbowData = elbowSub.LatestMessage;
disp(elbowData)
% 
% 
wristSub = rossubscriber('/joint4_position_controller/command', ...
    'std_msgs/Float64'); %Creación de suscriptor al tópico
pause(1)
wristData = wristSub.LatestMessage;
disp(wristData)
% 
% 
handSub = rossubscriber('/joint5_position_controller/command', ...
    'std_msgs/Float64'); %Creación de suscriptor al tópico
pause(1)
handData = handSub.LatestMessage;
disp(handData)

% pause(1)