% -- Calculo de M�dias e Retiradas de Arestas 0 --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

if exist('itimes','var') == 0
    itimes = '';
end

if exist('arestas0','var') == 0
    arestas0 = '';
end

tabela_medias = {};                             % Cria Tabela que vai conteras informa��s que ser�o
tabela_arestas_0 = {};                             % Cria Tabela que vai conteras informa��s que ser�o

arquivos = dir('*iTime_MoS.txt');               % Pega todos os arquivos iTime
tamArquivos = length(arquivos);                 % Tamanho do array de arquivos

for i = 1 : tamArquivos
    arquivo = arquivos(i).name;                 % Retorna nome de arquivo atual
 
    tabela = retornaMatriz('', arquivo);          % Retorna matriz com elementos do arquivo em tres colunas

    linha_cabecalho = tabela(1,:);              % Salva os valores de cabecalho
        
    tabela(1,:) = [];                           % Remove a linha de indices

    valores_tabela = str2double(tabela);        % Transforma os valores da matriz para double
    
    valores_tabela_total = valores_tabela;
    
    valores_tabela(valores_tabela(:, 2)== 0, :)=[];     %Retorna apenas as linhas cuja o valor da aresta (segunda coluna) nao seja 0.
    
    arestas_0 = length(valores_tabela_total) - length(valores_tabela);
    
    arestas = valores_tabela(:,2);              % Pega a coluna das arestas
    aglomeracao = valores_tabela(:,3);          % Pega a coluna dos coeficientes de aglomera��o

    mne = mean(arestas);                         % Calcula Media das arestas
    mcc = mean(aglomeracao);                     % Calcula media dos ccs

    stne = std(arestas);                         % Calcula desvio padr�o das arestas
    stcc = std(aglomeracao);                     % Calcula desvio padr�odos cc's

    tabela_medias(end+1,:) = {arquivo,mne,mcc,stne,stcc};   % Para cada arquivo, salva os valores acima para tabela
    tabela_arestas_0(end+1,:) = {arquivo,arestas_0};   % Para cada arquivo, salva os valores acima para tabela
end

caminho = pwd;                      % Pega caminho diretorio atual
diretorio = strsplit(caminho, '\'); % Divide o caminho em arrays com os nomes dos diretorios
tipo = diretorio{end};              % Pega o nome do diretorio atual
epoca = diretorio{end-1};           % Pega o nome do diretorio pai
nomeArquivo = strcat(itimes,epoca,'-',tipo,'-','Tabela_Medias_Desvios.txt'); % Gera nome do arquivo
nomeArquivo2 = strcat(arestas0,epoca,'-',tipo,'-','Tabela_Arestas_0.txt'); % Gera nome do arquivo

tabela_medias = cell2table(tabela_medias);
tabela_medias.Properties.VariableNames = {'Arquivo','MNE','MCC','STNE','STCC'};

writetable(tabela_medias,nomeArquivo,'Delimiter','\t')

tabela_arestas_0 = cell2table(tabela_arestas_0);
tabela_arestas_0.Properties.VariableNames = {'Arquivo','Arestas_0'};

writetable(tabela_arestas_0,nomeArquivo2,'Delimiter','\t')  
