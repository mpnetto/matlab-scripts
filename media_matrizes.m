% -- Calculo de Médias de matrizes --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

function arquivo = media_matrizes(txt)

    arquivos = dir(strcat('*',txt,'*'));            % Pega todos os arquivos iTime
    tamArquivos = length(arquivos);                 % Tamanho do array de arquivos

    tabela_matriz = [];

    for i = 1 : tamArquivos
        arquivo = arquivos(i).name;                 % Retorna nome de arquivo atual

        tabela = retornaMatriz('', arquivo);        % Retorna matriz com elementos do arquivo 
        
        linha_cabecalho = tabela(1,:);              % Salva os valores de cabecalho
        
        tabela(1,:) = [];                           % Remove a linha de indices

        coluna_indices = tabela(:,1);               % Salva os valores dos indices

        tabela(:,1) = [];                           % Remove a coluna de indices

        valores_tabela = str2double(tabela);        % Transforma os valores da matriz para double

        tabela_matriz = cat(3,valores_tabela,tabela_matriz); %Concatena todas as tabelas em uma matriz
    end

    media_matriz = mean(tabela_matriz,3);           % Tira as medias das matrizes     

    tabela_medias = horzcat(coluna_indices,num2cell(media_matriz));     % Concatena as medias com a coluna de indices

    caminho = pwd;                      % Pega caminho diretorio atual
    diretorio = strsplit(caminho, '\'); % Divide o caminho em arrays com os nomes dos diretorios
    tipo = diretorio{end};              % Pega o nome do diretorio atual
    nomeArquivo = strcat(txt,' - Tabela_Media_', tipo,'.txt'); % Gera nome do arquivo
    
    tabela_medias = cell2table(tabela_medias);
    tabela_medias.Properties.VariableNames = linha_cabecalho;
    
    writetable(tabela_medias,nomeArquivo,'Delimiter','\t')  

end
