% -- Calculo de Hubs --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

tabela_matriz = [];                             % Cria Tabela que vai conteras informaçõs que serão

tabela_contador = zeros(19,3);

arquivos = dir('*Hubs_MoS.txt');               % Pega todos os arquivos iTime
tamArquivos = length(arquivos);                 % Tamanho do array de arquivos

for i = 1 : tamArquivos
    arquivo = arquivos(i).name;                 % Retorna nome de arquivo atual
 
    tabela = retornaMatriz(arquivo,7);          % Retorna matriz com elementos do arquivo em tres colunas
    
    tabela(:,2:4) = [];                           % Remove a coluna que nao vao utilizar

    coluna_indices = tabela(:,1);               % Salva os valores dos indices
    
    tabela(:,1) = [];                           % Remove a coluna de indices
    
    valores_tabela = str2double(tabela);        % Transforma os valores da matriz para double
    
    valores_media = mean(valores_tabela,1);
    
    valores_desvio = std(valores_tabela,0, 1);
    
    valores_med_std = valores_media + valores_desvio;
    
    compara = bsxfun(@gt,valores_tabela,valores_med_std);
    
    tabela_contador = tabela_contador + compara;

end 

tabela_hubs = horzcat(coluna_indices,num2cell(tabela_contador));     % Concatena as medias com a coluna de indices

fido = fopen('SEG02_ASC - Demencia - Tabela_Media_Hubs.txt', 'wt');                                    % Abre arquivo 

fprintf(fido,'%s\t%s\t%s\t%s\n','Elect','Hubs','HubIn','HubOut');   % Imprime cabeçalho da tabela

for i = 1:size(tabela_hubs,1)    
    fprintf(fido,'%s\t%g\t%g\t%g\n',tabela_hubs{i,1},tabela_hubs{i,2},tabela_hubs{i,3},tabela_hubs{i,4});    %Imprime recursivamente as linhas da tabela         
end

fclose(fido); 
