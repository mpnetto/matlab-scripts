% -- Calculo de Médias de matrizes --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

arquivos = dir('* - Tabela_Media_Hubs*');               % Pega todos os arquivos iTime
tamArquivos = length(arquivos);                          % Tamanho do array de arquivos

tabela_matriz = [];

for i = 1 : tamArquivos
    arquivo = arquivos(i).name;                 % Retorna nome de arquivo atual
 
    tabela = retornaMatriz(arquivo,4);          % Retorna matriz com elementos do arquivo em cinco colunas
    
    coluna_indices = tabela(:,1);               % Salva os valores dos indices
    
    tabela(:,1) = [];                           % Remove a coluna de indices
    
    valores_tabela = str2double(tabela);        % Transforma os valores da matriz para double
    
    tabela_matriz = cat(3,valores_tabela,tabela_matriz); %Concatena todas as tabelas em uma matriz
end

media_matriz = sum(tabela_matriz,3);           % Soma as matrizes     

tabela_hubs = horzcat(coluna_indices,num2cell(media_matriz));     % Concatena as medias com a coluna de indices

fido = fopen('Tabela_Media_Hubs_Demencia.txt', 'wt');                                    % Abre arquivo 

fprintf(fido,'%s\t%s\t%s\t%s\n','Elect','Hubs','HubIn','HubOut');   % Imprime cabeçalho da tabela

for i = 1:size(tabela_hubs,1)    
    fprintf(fido,'%s\t%g\t%g\t%g\n',tabela_hubs{i,1},tabela_hubs{i,2},tabela_hubs{i,3},tabela_hubs{i,4});    %Imprime recursivamente as linhas da tabela         
end

fclose(fido);  
