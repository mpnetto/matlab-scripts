%% Simetria
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
% 

%% Calculo de Simetria
% O calculo de simetria é realizado a partir da soma dos indices E-Index,
% presente nos arquivos REA_G_MOS. O Objetivo do calculo é verificar se
% existem mais conexoes homofilicas (no mesmo hemisferio do nó), ou
% heterofilicas (conexoes entre hemisferios)


%% Modo de Usar
% Rodar o programa na pasta onde foram gerados os arquivos pelo TNETEEG. Os
% arquivos que este programa utiliza tem a extensão "iREA_MoS.txt.txt"

%% Scripts e documentos necessários
% * lerArquivo.m
% * escreverArquivo.m

% Cria Tabela das medias do grau ponderado
tabela_Mkp = {};

% Cria contador da somas das medias
soma_Mkp = 0;

% Retorna todos os arquivos que contem iREA_MoS*.txt no nome do arquivo
arquivos = dir('*iREA_MoS.txt');
tamArquivos = length(arquivos);

for i = 1 : tamArquivos
    % Retorna nome do arquivo e caminho
    arquivo = arquivos(i).name;
 
    % Retorna conteudo do arquivo em forma de tabela
    tabela = lerArquivo('', arquivo);
  
    % Remove cabeçalho 
    tabela(1,:) = [];
    
    % Retorna os indices E-index, converte para double e retira os
    % valores vazios
    eIndex = str2double(tabela(:,9));
    eIndex(isnan(eIndex)) = [];
    
    % Soma dos e-index e salva em uma tabela
    SumEIndex = sum(eIndex);
        
    tabela_EIndex(end+1,:) = {arquivo, MeIndex}
end

%% Salva tabela em arquivo
tabela_EIndex = cell2table(tabela_EIndex);
cabecalho = {'Arquivo','E-Index'};
escreveArquivo(tabela_EIndex,cabecalho,'Tabela Simetria - E-Index', '.txt');