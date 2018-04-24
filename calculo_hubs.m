% -- Calculo de Hubs --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

global hubs;

if exist('hubs','var') == 0
    hubs = '';
end

tabela_contador = zeros(19,3);

arquivos = dir('*Hubs_MoS.txt');                % Pega todos os arquivos Hubs_MoS
tamArquivos = length(arquivos);                 % Tamanho do array de arquivos

for i = 1 : tamArquivos
    arquivo = arquivos(i).name;                 % Retorna nome de arquivo atual
 
    tabela = retornaMatriz('', arquivo);        % Retorna matriz com elementos do arquivo
    
    tabela(:,2:4) = [];                         % Remove as colunas de 2 a 4
    
    linha_cabecalho = tabela(1,:);              % Salva os valores de cabecalho
        
    tabela(1,:) = [];                           % Remove a linha de indices

    coluna_indices = tabela(:,1);               % Salva os valores dos indices
    
    tabela(:,1) = [];                           % Remove a coluna de indices
    
    valores_tabela = str2double(tabela);        % Transforma os valores da matriz para double
    
    valores_media = mean(valores_tabela,1);     % Retorna array com as medias dos valores dos hubs
    
    valores_desvio = std(valores_tabela,0, 1);  % Retorna array com os desvios padroes dos valores dos hubs
    
    valores_med_std = valores_media + valores_desvio;   % Retorna array com a somas dos arrays das medias e desvios
    
    compara = bsxfun(@gt,valores_tabela,valores_med_std); % Compara e retorna a matriz logica dos valores que foram maiores que a media + desvio
    
    tabela_contador = tabela_contador + compara;          % Incrementa a matrix contadoras dos valores dos hubs que foram maiores que a media + desvio

end 

tabela_contador = tabela_contador/tamArquivos;

tabela_hubs = horzcat(coluna_indices,num2cell(tabela_contador));     % Concatena a matrix contadora com a coluna de indices

caminho = pwd;                      % Pega caminho diretorio atual
diretorio = strsplit(caminho, '\'); % Divide o caminho em arrays com os nomes dos diretorios
tipo = diretorio{end};              % Pega o nome do diretorio atual
epoca = diretorio{end-1};           % Pega o nome do diretorio pai
nomeArquivo = strcat(hubs,epoca,'-',tipo,'-','Tabela_Media_Hubs.txt'); % Gera nome do arquivo

tabela_hubs = cell2table(tabela_hubs);
tabela_hubs.Properties.VariableNames = linha_cabecalho;

writetable(tabela_hubs,nomeArquivo,'Delimiter','\t')  
