% -- Calculo de Médias de matrizes --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

arquivos = dir('*Tabela_Media_Ponderada*');               % Pega todos os arquivos iTime
tamArquivos = length(arquivos);                          % Tamanho do array de arquivos

tabela_matriz = [];

for i = 1 : tamArquivos
    arquivo = arquivos(i).name;                 % Retorna nome de arquivo atual
 
    tabela = retornaMatriz(arquivo,2);          % Retorna matriz com elementos do arquivo em cinco colunas
    
    coluna_indices = tabela(:,1);               % Salva os valores dos indices
    
    tabela(:,1) = [];                           % Remove a coluna de indices
    
    valores_tabela = str2double(tabela);        % Transforma os valores da matriz para double
    
    tabela_matriz = cat(3,valores_tabela,tabela_matriz); %Concatena todas as tabelas em uma matriz
end

media_matriz = mean(tabela_matriz,3);           % Tira as medias das matrizes     

tabela_medias = horzcat(coluna_indices,num2cell(media_matriz));     % Concatena as medias com a coluna de indices

fido = fopen('Tabela_Media_Controle.txt', 'wt');                                    % Abre arquivo 

fprintf(fido,'%s\t%s\n','Arquivo','Mkp');   % Imprime cabeçalho da tabela

for i = 1:size(tabela_medias,1)    
    fprintf(fido,'%s\t%g\n',tabela_medias{i,1},tabela_medias{i,2});    %Imprime recursivamente as linhas da tabela         
end

fclose(fido);   
