%% Hubs das Arestas
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
% 


%% Calculo de Hub das Aretas
% O calculo de hub das arestas é utilizado para calcular as arestas hubs. É
% criado uma matriz de adjacencia a partir de analise de conexoes dos
% eletrodos gerados pelo programa TNETEEG, e mantidos apenas as conexoes
% que tem o peso de suas arestas acima da média + 2 desvios padrões.


%% Modo de Usar
% Rodar o programa na pasta onde foram gerados os arquivos pelo TNETEEG. Os
% arquivos que este programa utiliza tem a extensão "REA_G_MoS*.txt"

%% Scripts e documentos necessários
% 
% * retornaMatriz.m
% * plotWeiREA.m
% * Location32.txt

%% Imagens
% <<C:\Users\Mandelbrot\Documents\Marcos\Dados Originais Demencia\Controle (1)\C016_EC10S_REA_G_MoS.PNG>>

% Definição do nome dos eletrodos
nos_ids={'Fp1';'Fp2';'F7';'F8';'F3';'F4';'T3'; 'T4';'C3'; ...
    'C4';'T5'; 'T6'; 'P3';'P4';'O1';'O2';'Fz';'Pz';'Cz'}; 

% Salva as coordenadas dos eletrodos e retorna apenas os que serão
% utilizaods
coord = retornaMatriz( '', 'Location32.txt');             
coord(1,:) = [];
elecs = ismember(coord(:,1), nos_ids);
coord(~elecs, :)=[];
coord(:,1)=[];
coord = str2double(coord);

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

    % Define figura para receber os dados do plot
    fig = figure;
    set(fig, 'Visible', 'off');

    % Plota os hubs das arestas e salva em um arquivo de mesmo nome no
    % formato PNG
    plotWeiREA(tabela,coord,nos_ids);
    saveas(fig,nome, 'png');
end
