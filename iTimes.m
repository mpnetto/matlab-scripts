%% Médias e Desvios com Retirada de Arestas 0
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
% 

%% Calculo das médias e desvios com retirada de Arestas 0
% É retirado todas as arestas que tem o peso 0 e calculado a média e o
% desvio das arestas e dos coeficientes de variação. 


%% Modo de Usar
% Rodar o programa na pasta onde foram gerados os arquivos pelo TNETEEG. Os
% arquivos que este programa utiliza tem a extensão "iTime_MoS*.txt"

%% Scripts e documentos necessários
% * lerArquivo.m
% * escreveArquivo.m

% Cria tabela das medias
tabela_medias = {};

% Retorna todos os arquivos que contem iTime_MoS*.txt no nome do arquivo
arquivos = dir('*iTime_MoS*.txt');
tamArquivos = length(arquivos);

for i = 1 : tamArquivos
    % Retorna nome de arquivo atual
    arquivo = arquivos(i).name;
 
    % Retorna conteudo do arquivo
    tabela = lerArquivo('', arquivo);
    
    % Salva os valores de cabecalho e remove
    linha_cabecalho = tabela(1,:);
    tabela(1,:) = [];
    
    % Transforma os valores da matriz para double
    valores_tabela = str2double(tabela);
    
    % Apaga as linhas cuja valor da aresta seja 0
    valores_tabela(valores_tabela(:, 2)== 0, :)=[];
    
    % salva as colunas das arestas e dos coeficientes de aglomeração
    arestas = valores_tabela(:,2);
    aglomeracao = valores_tabela(:,3);
    
    % Calcula as medias e os desvios padrões das arestas e dos coeficientes
    mne = mean(arestas);
    mcc = mean(aglomeracao);
    stne = std(arestas); 
    stcc = std(aglomeracao);
    
    % Salva os valores na tabela
    tabela_medias(end+1,:) = {arquivo,mne,mcc,stne,stcc};
end

tabela_medias = cell2table(tabela_medias);

cabecalho = {'Arquivo','MNE','MCC','STNE','STCC'};

escreveArquivo(tabela_medias,cabecalho,'Medias & Desvios - Arestas & Aglomeracao ', '.txt');