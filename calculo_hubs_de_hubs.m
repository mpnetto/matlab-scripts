%% Hubs de Hubs
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
% 

%% Calculo dos Hubs de Hubs
% O calculo dos hubs dos hubs é utilizado para calcular quem são quais são
% nós que possuem maiores conexoes entre os já dito Hubs. 


%% Modo de Usar
% Rodar o programa na pasta onde foram gerados os arquivos pelo TNETEEG. Os
% arquivos que este programa utiliza tem a extensão "Hubs_MoS*.txt"

%% Scripts e documentos necessários
% 
% * lerArquivo.m
% * escreverArquivo.m

% Cria uma tabela de zeros na mesma dimensao da quantidade de eletrodos
% (19) e colunas dos hubs (3)
tabela_contador = zeros(19,3);

% Retorna todos os arquivos que contem Hubs_MoS.txt no nome do arquivo
arquivos = dir('*Hubs_MoS*.txt');
tamArquivos = length(arquivos);

for i = 1 : tamArquivos
    % Retorna nome do arquivo e caminho
    arquivo = arquivos(i).name;
    [cam,nome,ext] = fileparts(arquivos(i).name);
 
    % Retorna conteudo do arquivo em forma de tabela
    tabela = lerArquivo('', arquivo);
    
    tabela(:,2:4) = [];
    
    % Salva cabecalho e remove
    linha_cabecalho = tabela(1,:);
    tabela(1,:) = [];

    % Salva os valores dos indices e remove da tabela
    coluna_indices = tabela(:,1);
    tabela(:,1) = [];
    
    % Transforma os valores da matriz para double
    valores_tabela = str2double(tabela);        
    
    % calcula a media, o desvio e a soma dos dois e salva em um array
    valores_media = mean(valores_tabela,1);
    valores_desvio = std(valores_tabela,0, 1);
    valores_med_std = valores_media + valores_desvio;
    
    % Compara e retorna a matriz logica dos valores que foram maiores que a media + desvio
    compara = bsxfun(@gt,valores_tabela,valores_med_std); 
    
    % Incrementa a matrix contadoras dos valores dos hubs que foram maiores que a media + desvio
    tabela_contador = tabela_contador + compara;          
end 

% Calcula a média dos contadores pelo numero de individuos e adiciona a
% coluna de indices
tabela_contador = tabela_contador/tamArquivos;
tabela_hubs = horzcat(coluna_indices,num2cell(tabela_contador));     

%% Salva tabela em arquivo

tabela_hubs = cell2table(tabela_hubs);
escreveArquivo(tabela_hubs,linha_cabecalho,'Tabela Media Hubs', '.txt');

