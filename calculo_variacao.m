% -- Calculo de Variaçao --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

if exist('variacao','var') == 0
    variacao = '';
end

if ~exist('arquivo','var')
    tabela = retornaMatriz('Selecione o Arquivo');  % Retorna matriz com elementos do arquivo
else
    tabela = retornaMatriz('',arquivo);  % Retorna matriz com elementos do arquivo
end

linha_cabecalho = tabela(1,:);              % Salva os valores de cabecalho
        
tabela(1,:) = [];                           % Remove a linha de indices

coluna_indices = tabela(:,1);               % Salva os valores dos indices
    
tabela(:,1) = [];                           % Remove a coluna de indices

valores_tabela = str2double(tabela);        % Transforma os valores da matriz para double

mne = valores_tabela(:,1);                  % Medias das Arestas
mcc = valores_tabela(:,2);                  % Medias dos Coeficientes de Aglomeracao

stne = valores_tabela(:,3);                 % Desvio Padrao das Arestas
stcc = valores_tabela(:,4);                 % Desvio Padrao dos Coeficientes de Aglomeracao

cva = rdivide(stne,mne)*100;                % Coeficiente de variacao das arestas           
cvag = rdivide(stcc,mcc)*100;               % Coeficiente de variacao da aglomeracao

tabela_cva = horzcat(coluna_indices,num2cell(cva));     % Concatena o cva com a coluna de indices

tabela_cvag = horzcat(coluna_indices,num2cell(cvag));   % Concatena o cvag com a coluna de indices

caminho = pwd;                      % Pega caminho diretorio atual
diretorio = strsplit(arquivo, '-'); % Divide o caminho em arrays com os nomes dos diretorios
tipo = diretorio{end-1};              % Pega o nome do diretorio atual
nomeArquivo1 = strcat(variacao,tipo,' - ','Coeficiente_Variacao_Aresta.txt'); % Gera nome do arquivo
nomeArquivo2 = strcat(variacao,tipo,' - ','Coeficiente_Variacao_Aglomeracao.txt'); % Gera nome do arquivo

tabela_cva = cell2table(tabela_cva);
tabela_cva.Properties.VariableNames = {'INDIV','CVA'};

writetable(tabela_cva,nomeArquivo1,'Delimiter','\t')  

tabela_cvag = cell2table(tabela_cvag);
tabela_cvag.Properties.VariableNames = {'INDIV','CVAg'};

writetable(tabela_cvag,nomeArquivo2,'Delimiter','\t')  


