%%% Funci�n dhParams(theta,d,a,alpha).
% Esta funci�n recibe los par�metros de Denavit y Hartenberg de una
% articulaci�n espec�fica y regresa la matriz de transformaci�n homog�nea
% asociada a dicha articulaci�n. 
%


function dhMatrix=dhParameters(theta, d, a, alfa)
dhMatrix=[cos(theta) -cos(alfa)*sin(theta) sin(alfa)*sin(theta) a*cos(theta);
 sin(theta) cos(alfa)*cos(theta) -sin(alfa)*cos(theta) a*sin(theta);
 0 sin(alfa) cos(alfa) d;
 0 0 0 1];