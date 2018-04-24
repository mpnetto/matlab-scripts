
global itimes;              
global hubs;
global irea;
global variacao;
global bootstrap;
global arquivo
global tipo;
global arestas0;
                   
dadosDir = 'Dados';
iTimesDir = 'Itimes';
ireaDir = 'iRea';
hubsDir = 'Hubs';
bootstrapDir = 'BootStrap';
variacaoDir = 'Coeficientes de Variacao';
arestas0Dir = 'Arestas 0';

caminho = pwd;  
dados = strcat(caminho,'\',dadosDir,'\');
itimes = strcat(dados,iTimesDir,'\');
variacao = strcat(itimes,variacaoDir,'\');
hubs = strcat(dados,hubsDir,'\');
irea = strcat(dados,ireaDir,'\');
bootstrap = strcat(variacao,bootstrapDir,'\');
arestas0 = strcat(itimes,arestas0Dir,'\');

if exist(dadosDir, 'dir') == 0
    mkdir(dadosDir);
    mkdir(itimes);
    mkdir(hubs);
    mkdir(irea);
    mkdir(variacao);
    mkdir(bootstrap);
end

A = dir;
for i = 4:length(A)
    currA = A(i).name; % Nome do subdiretorio
    cd(currA) % Troca para o subdiretorio
    
    B = dir;
    for j = 3:length(B) 
        currB = B(j).name; 
        cd(currB)
        iTimes;
        calculo_hubs;
        calculo_grau_ponderado
        cd('..')
    end
    cd('..')
end


cd(itimes);

arquivo = media_matrizes('Pacientes');
calculo_variacao;
arquivo = media_matrizes('Controle');
calculo_variacao;

cd(variacao);

tipo = 'Aresta';
BootStrap_2;
tipo = 'Aglomeracao';
BootStrap_2;

cd(hubs)

soma_matrizes('Pacientes');
soma_matrizes('Controle');

cd(irea)

arquivo = media_matrizes('Pacientes');
arquivo = media_matrizes('Controle');

cd(dados)
cd('..')


