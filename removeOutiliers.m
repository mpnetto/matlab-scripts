%% remove
% Autor: Marcos Netto
%
% email: mpnetto88@gmail.com

nome_arquivo = 'Tabela_Media_Ponderada';

tabela = retornaMatriz( 'Selecione um documento para remover Outliers');

linha_cabecalho = tabela(1,:);              % Salva os valores de cabecalho
        
tabela(1,:) = [];                           % Remove a linha de indices

coluna_indices = tabela(:,1);               % Salva os valores dos indices
    
tabela(:,1) = [];                           % Remove a coluna de indices

valores_tabela = str2double(tabela);        % Transforma os valores da matriz para double

while 1
    ma = mean(valores_tabela(:,1));                             % Media das Medias das Arestas
    sta = std(valores_tabela(:,1));                             % Desvio das medias das Arestas
    
    corte_cima = ma+sta*3;
    
    corte_baixo = ma-sta*3;

    log = valores_tabela(:, 1)< corte_cima& valores_tabela(:, 1)>corte_baixo;

    antiga_tabela = valores_tabela;
    valores_tabela = valores_tabela(log);
    coluna_indices = coluna_indices(log);

    atl = length(antiga_tabela);                % Tamanho da tabela gerada
    vtl = length(valores_tabela);               % Tamanho da tabela antiga

    if (atl == vtl | vtl == 0)
        break;
    end
end

tabela = horzcat(coluna_indices,num2cell(valores_tabela));     % Concatena o cva com a coluna de indices

nomeArquivo = strcat(nome_arquivo,'-','sem_outliers.txt'); % Gera nome do arquivo

tabela = cell2table(tabela);

writetable(tabela,nomeArquivo,'Delimiter','\t');


