%% E-Index dos hubs das arestas
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
% 

%% Calculo de E-index dos hubs das arestas
% Calculo dos E-index da rede para verificar se a rede é heterofilica(mais
% conexões entre hemisferios) ou homofílica (mais conexões em um mesmo
% hemisfério)


%% Modo de Usar
% Rodar o programa na pasta onde foram gerados os arquivos pelo TNETEEG. Os
% arquivos que este programa utiliza tem a extensão "REA_G_MoS*.txt"

%% Scripts e documentos necessários
% * lerArquivo.m
% * escreveArquivo

% Definição do nome dos eletrodos
nos_ids={'Fp1';'Fp2';'F7';'F8';'F3';'F4';'T3'; 'T4';'C3'; ...
    'C4';'T5'; 'T6'; 'P3';'P4';'O1';'O2';'Fz';'Pz';'Cz'};


% Nós que fazem parte das conexões do hemisfério esquerdo
nos_esq = {'Fp1';'F7';'F3';'T3'; 'C3';'T5'; 'P3';'O1';'Fz';'Pz';'Cz'};

% Nós que fazem parte das conexões do hemisfério direito
nos_dir={'Fp2';'F8';'F4'; 'T4';'C4'; 'T6';'P4';'O2';'Fz';'Pz';'Cz'};

% Nós que fazem parte das conexões do centro
nos_centro={'Fz';'Pz';'Cz'};

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
    
    % Transforma a tabela em um grafo
    nos = tabela(:,1);
    nos_adjacentes = tabela(:,2);
    pesos = tabela(:,3);
    grafo = graph(nos,nos_adjacentes,pess, nos_ids);
    
    % Divide o grafo em subgrafos de esquerda, direita e centro
    rede_esq = subgraph(grafo, nos_esq);
    rede_dir = subgraph(grafo, nos_dir);
    rede_centro = subgraph(grafo, nos_dir);
    
    % Calcula quantidade de conexoes realizadas em cada subrede
    conexoes_esq = height(rede_esq.Edges);
    conexoes_dir = height(rede_dir.Edges);
    conexoes_centro = height(rede_centro.Edges);
    total_conexoes = height(grafo.Edges);
    
    % Numero de conexoes é iguala soma das conexoes de ambos os lados do
    % hemisfério subtraindo a subrede central, que seria o cnjunto
    % interceção
    IL = conexoes_esq + conexoes_dir - conexoes_centro;
    EL = total_conexoes - IL;
    
    % Calcula o valor do E-Index
    eIndex = (EL - IL)/(EL + IL);    
end