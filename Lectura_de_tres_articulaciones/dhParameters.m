%%% Función dhParams(theta,d,a,alpha).
% Esta función recibe los parámetros de Denavit y Hartenberg de una
% articulación específica y regresa la matriz de transformación homogénea
% asociada a dicha articulación. 
%


function dhMatrix=dhParameters(theta, d, a, alfa)
dhMatrix=[cos(theta) -cos(alfa)*sin(theta) sin(alfa)*sin(theta) a*cos(theta);
 sin(theta) cos(alfa)*cos(theta) -sin(alfa)*cos(theta) a*sin(theta);
 0 sin(alfa) cos(alfa) d;
 0 0 0 1];