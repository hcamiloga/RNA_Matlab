clc       % borra el escritorio
clear all % borra las variables del workspace

%% ---  Patrones ---
datos = csvread('clima_numerico.csv');

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

datos(:,2)=datos(:,2)/max(datos(:,2));
datos(:,3)=datos(:,3)/max(datos(:,3));

X = datos(1:cant, 1:4)';
T = datos(1:cant,5)';


[Atrib, CantPatrones] = size(X);

%% --- Plano inicial ---
%% W = rand(1,Atrib);  % vector fila con valores aleatorios entre -1 y 1  
%% b = rand;  % bias o t�rmino de tendencia

vec_alfa = 0.1:0.2:2;
cant_alfa=size(vec_alfa);
MAX_ITE = 100000;
resultados=[];

%archivo_salida=fopen('salidaP1_N1.txt','w');

%% Recorrer diferentes valores de ALFA
for alfas=1:cant_alfa(2)
    
%     W = zeros(1,Atrib);
%     b = 0;
    
    W = 2*rand(1,Atrib)-1;
    b = 2*rand-1;
    %% Entrenamiento del perceptron para un valor de alfa
    alfa=vec_alfa(alfas);
    ite = 0;
    hubo_cambio = 1;
    while ((ite < MAX_ITE) && (hubo_cambio==1))
        ite = ite + 1;
        hubo_cambio = 0;

        for patr = 1: CantPatrones   % para cada patron
           neta = W * X(:, patr) + b;
           salida = ( neta > 0 ) ;


           if (T(patr)~=salida)   %ver si esta mal clasificado
             hubo_cambio = 1;
             % cambiar W si corresponde
             W = W + alfa *(T(patr)-salida) * X(:,patr)';
             b = b + alfa *(T(patr)-salida);
           end


        end
      %  fprintf(archivo_salida,'%f\t%f\t%f\t%f\t%f\t%f\t%f\n',ite,alfa,W(1),W(2),W(3),W(4),b);
        resultados(alfas,ite,:)=[ite W(1) W(2) W(3) W(4) b];


    end
    %fclose(archivo_salida);
%     alfaSTR=num2str(alfa);
%     alfaSTR=strrep(alfaSTR,'.','_');
%     nombreVar=strcat('resultado__',alfaSTR);
%     save(nombreVar,'resultados');
    alfa
    ite
    
end

a='Fin'
save('ParametrosEscOrd01__InicialRand','resultados');