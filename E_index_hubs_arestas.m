%% E-Index dos hubs das arestas
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
% 


%% Calculo de E-index dos hubs das arestas



%% Modo de Usar
% Rodar o programa na pasta onde foram gerados os arquivos pelo TNETEEG. Os
% arquivos que este programa utiliza tem a extensão "REA_G_MoS*.txt"

%% Scripts e documentos necessários
% 
% * retornaMatriz.m
% * Location32.txt

% Definição do nome dos eletrodos
nos_ids={'Fp1';'Fp2';'F7';'F8';'F3';'F4';'T3'; 'T4';'C3'; ...
    'C4';'T5'; 'T6'; 'P3';'P4';'O1';'O2';'Fz';'Pz';'Cz'};

nos_esq = {'Fp1';'F7';'F3';'T3'; 'C3';'T5'; 'P3';'O1'};%;'Fz';'Pz';'Cz'};

nos_dir={'Fp2';'F8';'F4'; 'T4';'C4'; 'T6';'P4';'O2'};%;'Fz';'Pz';'Cz'};

% Retorna todos os arquivos que contem REA_G_MoS*.txt no nome do arquivo
arquivos = dir('*REA_G_MoS*.txt');
tamArquivos = length(arquivos);


for i = 1 : tamArquivos

    % Retorna nome do arquivo e nome
    arquivo = arquivos(i).name;
    [cam,nome,ext] = fileparts(arquivos(i).name);
 
    % Retorna conteudo do arquivo em forma de tabela
    tabela = retornaMatriz('', arquivo);
 
    % Remove cabeçalho e 4ª coluna
    tabela(1,:) = [];
    tabela(:,4) = [];

    % Converte valores da tabela para double
    tabela = str2double(tabela);

    % Identifica os outliers (média + 2 desvios padrões)
    outlier = isoutlier(tabela(:,3), 'mean', 'ThresholdFactor',2);
 
    % Remove os outliers
    tabela(~outlier, :)=[];
    
    A = tabela(:,1);
    B = tabela(:,2);
    C = tabela(:,2);
    grafo = graph(A,B,C, nos_ids);
    
    rede_esq = subgraph(grafo, nos_esq);
    rede_dir = subgraph(grafo, nos_dir);
    
    conexoes_esq = height(rede_esq.Edges);
    conexoes_dir = height(rede_dir.Edges);
    total_conexoes = height(grafo.Edges);
    
    IL = conexoes_esq + conexoes_dir
    EL = total_conexoes - IL
    
    eIndex = (EL - IL)/(EL + IL)
    
    
    
    
end