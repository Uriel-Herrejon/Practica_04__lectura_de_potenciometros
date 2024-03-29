%% Limpia la memoria de variables
clear all
close all
clc

%% Cierra y elimina cualquier objeto de tipo serial 

if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end

%% Creaci�n de un objeto tipo serial
% Se declara una variable que lee el puerto de comunicaci�n serial que se
%tiene con el arduino y la velocidad.
arduino = serial('COM5','BaudRate',9600);
% Habre la comunicaci�n serial con el arduino
fopen(arduino);
% Se detecta si el arduino esta conectado o desconectado
if arduino.status == 'open'
    disp('Arduino conectado correctamente \n');
else
    disp('No se ha conectado el arduino \n');
    return
end

%% Se pide la longuitud de la primera articulaci�n
L1= input('Ingresa la longitud para la articulaci�n 1:\n');

%% Se establece el punto 0
p1=[0 0 0]';

%% Se establece el n�mero de muestras y el contador para pder utilizarlos
% en el blucle principal 
numero_muestras = 1000;
y = zeros(1,numero_muestras); 
contador_muestras = 1; 
% Se le da un nombre a la grafica de muestreo, ademas de establecer los
% valores del eje x y del eje y
figure('Name','Serial communication: Matlab + Arduino. TESE-Rob�tica')
title('SERIAL COMMUNICATION MATLAB + ARDUINO');
xlabel('N�mero de muestra');
ylabel('Valor');
grid on;
hold on;
% Se realiza un bucle secuencial principal
while 1
    %% Se encarga de ir borrando cada uno de los trazos realizados 
    clf 
    %%  Esta funci�n fue creada en otro script con el c�digo para  
    % establecer los ejes del plano carteciano, los cuales por el 
    % por el momento son el eje X y el eje Y
    printAxis();
    %% Se le el valor del potenciometro del arduino el cual solo le� el 
    % valor de un potenciometro 
    valor_potenciometro = fscanf(arduino,'%d');
    %% Se le el valor del unico potenciometro -512 a 512 
    angdeg = (valor_potenciometro(1)-512)*130/512;
    %% Se convierten los grados a radianes
    angrad = deg2rad(angdeg);
    %% Se coloc� la matriz de rotaci�n en el eje Z
    TRz1 = [ cos(angrad) -sin(angrad) 0 0 ; sin(angrad) cos(angrad) 0 0 ; 0 0 1 0;  0 0 0 1 ];
   %% Se coloca la matriz traslacion en el eje X dejando como variable L1 
   % la cual ser� introducida por el usuario
    TTx1 = [ 1 0 0 L1; 0 1 0 0; 0 0 1 0; 0 0 0 1]; 
    % Se guarda en la variable T1 la multiplicaci�n de la matriz de
    %rotaci�n en el eje Z y la matriz de traslaci�n en el eje X para 
    %poder crear una matriz de transformacion homogenea y poder realizar la
    %impresi�n de las lineas
    T1 = TRz1 * TTx1; 
    %% Se encarga de tomar la posicion final de la matriz  T1 recuperando 
    %el valor 1 hasta el 3 de la columna 4
    p2 = T1 (1:3,4); 
    %% Se iestablecen los puntos de los mini ejes
    eje_x_1 = T1(1:3,1); 
    eje_y_1 = T1(1:3,2);     
    %%% Se realiza la impresi�n final del eslabon 1 
    line([p1(1) p2(1)],[p1(2) p2(2)],[p1(3) p2(3)],'linewidth',4) 
    %% Se imprimen los mini ejes
    line([p1(1) eje_x_1(1)],[p1(2) eje_x_1(2)],[p1(3) eje_x_1(3)],'linewidth',5,'color',[0 0 0])
    line([p1(1) eje_y_1(1)],[p1(2) eje_y_1(2)],[p1(3) eje_y_1(3)],'linewidth',5,'color',[0 0 0])
    pause(0.01);
end

%% Cierre de puertos 
fclose(arduino);
delete(arduino);
clear all; 


