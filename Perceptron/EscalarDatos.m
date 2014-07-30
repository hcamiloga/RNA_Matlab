clc       % borra el escritorio
clear all % borra las variables del workspace

%% ---  Patrones ---

datos = csvread('clima_numerico.csv');

cant = size(datos,1);

datos(:,2)=datos(:,2)/max(datos(:,2))
datos(:,3)=datos(:,3)/max(datos(:,3))


X = datos(1:cant, 1:4)';
T = datos(1:cant,5)';


[Atrib, CantPatrones] = size(X);

