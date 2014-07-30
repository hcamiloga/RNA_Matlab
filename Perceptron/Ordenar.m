clc       % borra el escritorio
clear all % borra las variables del workspace

%% ---  Patrones ---

datos = csvread('clima_numerico.csv');
datosControl = csvread('clima_numerico.csv');
datos_cero=[];
datos_uno=[];
for x=1:size(datos,1)
   
    if (datos(x,5)==0)
        datos_cero=[datos_cero;datos(x,:)];
    else
        datos_uno=[datos_uno;datos(x,:)];
        
    end
    
end

datos=[datos_cero;datos_uno];

cant = size(datos,1);

X = datos(1:cant, 1:4)';
T = datos(1:cant,5)';


[Atrib, CantPatrones] = size(X);