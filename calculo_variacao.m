%% Coeficiente de Variacao
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
% 

%% Calculo de coeficiente de variacao
% O calculo de coeficiente de variacao 


%% Modo de Usar
% Rodar o programa na pasta onde foram gerados os arquivos pelo TNETEEG. Os
% arquivos que este programa utiliza tem a extens�o "REA_G_MoS*.txt"

%% Scripts e documentos necess�rios
% 
% * lerArquivo.m
% * escreverArquivo

tabela = lerArquivo( 'Selecione um arquivo');
        
tabela(1,:) = [];

% Salva os valores dos indices e remove da tabela
coluna_indices = tabela(:,1);
tabela(:,1) = [];

% Transforma os valores da tabela para double
valores_tabela = str2double(tabela);        

% Salva os valores das media e desvio das arestas e media e desvio do
% coeficiente de aglomeracao
mne = valores_tabela(:,1);
mcc = valores_tabela(:,2);
stne = valores_tabela(:,3);
stcc = valores_tabela(:,4);


% Calcula os coeficientes de variacao das arestas e da aglomaraca
cva = rdivide(stne,mne)*100;        
cvag = rdivide(stcc,mcc)*100;

% Salva os valores calculados em suas respectivas tabelas
tabela_cva = horzcat(coluna_indices,num2cell(cva));
tabela_cvag = horzcat(coluna_indices,num2cell(cvag));

nomeArquivo1 = strcat(tipo,' - ','Coeficiente_Variacao_Aresta.txt'); % Gera nome do arquivo
nomeArquivo2 = strcat(tipo,' - ','Coeficiente_Variacao_Aglomeracao.txt'); % Gera nome do arquivo

tabela_cva = cell2table(tabela_cva);
cabecalho_cva = {'INDIV','CVA'};
escreveArquivo(tabela_cva,cabecalho_cva,'Coeficiente Variacao Aresta', '.txt');  

tabela_cvag = cell2table(tabela_cvag);
cabecalho_cvag = {'INDIV','CVAg'};
escreveArquivo(tabela_cvag,cabecalho_cvag,'Coeficiente Variacao Aglomeracao', '.txt');  


