% -- Calculo de Variaçao --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

tipo = 'Controle';

tabela = retornaMatriz('Selecione o Arquivo');  % Retorna matriz com elementos do arquivo

linha_cabecalho = tabela(1,:);              % Salva os valores de cabecalho
        
tabela(1,:) = [];                           % Remove a linha de indices

coluna_indices = tabela(:,1);               % Salva os valores dos indices
    
tabela(:,1) = [];                           % Remove a coluna de indices

valores_tabela = str2double(tabela);        % Transforma os valores da matriz para double

%while 1
    %mne = valores_tabela(:,1);                  % Medias das Arestas

    %ma = mean(mne);                             % Media das Medias das Arestas
    %sta = std(mne);                             % Desvio das medias das Arestas
    
    %antiga_tabela = valores_tabela;
    %valores_tabela(valores_tabela(:, 1)> ma+sta*2 | valores_tabela(:, 1)<ma-sta*2, :)= [];
    
    %atl = length(antiga_tabela);                % Tamanho da tabela gerada
    %vtl = length(valores_tabela);               % Tamanho da tabela antiga
    
    %if (atl == vtl | vtl == 0)
        %break;
    %end
%end

mne = valores_tabela(:,1);                  % Medias das Arestas
mcc = valores_tabela(:,2);                  % Medias dos Coeficientes de Aglomeracao

stne = valores_tabela(:,3);                 % Desvio Padrao das Arestas
stcc = valores_tabela(:,4);                 % Desvio Padrao dos Coeficientes de Aglomeracao

cva = rdivide(stne,mne)*100;                % Coeficiente de variacao das arestas           
cvag = rdivide(stcc,mcc)*100;               % Coeficiente de variacao da aglomeracao

tabela_cva = horzcat(coluna_indices,num2cell(cva));     % Concatena o cva com a coluna de indices

tabela_cvag = horzcat(coluna_indices,num2cell(cvag));   % Concatena o cvag com a coluna de indices

nomeArquivo1 = strcat(tipo,' - ','Coeficiente_Variacao_Aresta.txt'); % Gera nome do arquivo
nomeArquivo2 = strcat(tipo,' - ','Coeficiente_Variacao_Aglomeracao.txt'); % Gera nome do arquivo

tabela_cva = cell2table(tabela_cva);
tabela_cva.Properties.VariableNames = {'INDIV','CVA'};

writetable(tabela_cva,nomeArquivo1,'Delimiter','\t')  

tabela_cvag = cell2table(tabela_cvag);
tabela_cvag.Properties.VariableNames = {'INDIV','CVAg'};

writetable(tabela_cvag,nomeArquivo2,'Delimiter','\t');
