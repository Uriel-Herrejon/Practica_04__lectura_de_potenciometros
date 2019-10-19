%% Limpia la memoria de variables
clear all
close all
clc

%% Cierra y elimina cualquier objeto de tipo serial 
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%% Creación de un objeto tipo serial
arduino = serial('COM5','BaudRate',9600);
fopen(arduino);
if arduino.status == 'open'
    disp('Arduino conectado correctamente');
else
    disp('No se ha conectado el arduino ');
    return
end

%% Lectura de distancias
prompt = 'Introduza la longitud del primer eslabon (l1): ';
l1 = input(prompt);
prompt = 'Introduza la longitud del primer eslabon (l2): ';
l2 = input(prompt);
prompt = 'Introduza la longitud del primer eslabon (l3): ';
l3 = input(prompt);

%% Definición de los parametros de Denavit-Hartenberg
d1 = l1;
d2 = 0;
d3 = 0;

a1 = 0;
a2 = l2;
a3 = l3;

alpha_1 = 90;
alpha_2 = 0;
alpha_3 = 0;
alpha_1_rad = deg2rad(alpha_1);
alpha_2_rad = deg2rad(alpha_2);
alpha_3_rad = deg2rad(alpha_3);

%% Definición del punto inicial del robot
p1 = [0,0,0];

while 1 
    clf
    printAxis();
    grid on
    a = fscanf(arduino,'%d,%d,%d')';
    angdeg = (a(1)-512)*130/512;
    theta1_rad = deg2rad(angdeg); 
    Rotz = [cos(theta1_rad) -sin(theta1_rad)  0; sin(theta1_rad) cos(theta1_rad) 0; 0 0 1];
    A1 = dhParameters(theta1_rad,d1,a1,alpha_1_rad);
    A2 = dhParameters(0,d2,a2,alpha_2_rad);
    A3 = dhParameters(0,d3,a3,alpha_3_rad);
    
    A12 = A1*A2;
    A123 = A1*A2*A3; 

    p1 = [0 0 0]';
    p2 = A1(1:3,4);
    p3 = A12(1:3,4);
    p4 = A123(1:3,4);
    
    printLink(p1,p2);
    printLink(p2,p3);
%     printLink(p3,p4);
    printMiniAxes(p1,Rotz);
    printMiniAxes(p2,A12);
    printMiniAxes(p3,A123);
%     printMiniAxes(p4,A123);
    view(30,30);
    
    
    
    printAxis();
    clf
    grid on 
    angdeg2 = (a(2)-512)*130/512;
    theta2_rad = deg2rad(angdeg2);
    Rotz = [cos(theta1_rad) -sin(theta1_rad)  0; sin(theta1_rad) cos(theta1_rad) 0; 0 0 1];
    A1 = dhParameters(theta1_rad,d1,a1,alpha_1_rad);
    A2 = dhParameters(theta2_rad,d2,a2,alpha_2_rad);
    A3 = dhParameters(0,d3,a3,alpha_3_rad);
    
    A12 = A1*A2;
    A123 = A1*A2*A3; 

    p1 = [0 0 0]';
    p2 = A1(1:3,4);
    p3 = A12(1:3,4);
    p4 = A123(1:3,4);
    
    printLink(p1,p2);
    printLink(p2,p3);
%     printLink(p3,p4);
    printMiniAxes(p1,Rotz);
    printMiniAxes(p3,A123);
%     printMiniAxes(p4,A123);
    view(30,30);
    
    
    printAxis();
    
    grid on 
    angdeg_3 = (a(3)-512)*130/512;
    theta3_rad = deg2rad(angdeg_3);
    Rotz = [cos(theta3_rad) -sin(theta3_rad)  0; sin(theta3_rad) cos(theta3_rad) 0; 0 0 1];
    A1 = dhParameters(theta1_rad,d1,a1,alpha_1_rad);
    A2 = dhParameters(theta2_rad,d2,a2,alpha_2_rad);
    A3 = dhParameters(theta3_rad,d3,a3,alpha_3_rad);
    
    A12 = A1*A2;
    A123 = A1*A2*A3; 

    p1 = [0 0 0]';
    p2 = A1(1:3,4);
    p3 = A12(1:3,4);
    p4 = A123(1:3,4);
    
    printLink(p1,p2);
    printLink(p2,p3);
    printLink(p3,p4);
    printMiniAxes(p1,Rotz);
    printMiniAxes(p2,A12);
    printMiniAxes(p3,A123);
    printMiniAxes(p4,A123);
    view(30,30);
    
   pause(0.01);
end
%% Cierre de puertos 
fclose(arduino);
delete(arduino);
clear all; 