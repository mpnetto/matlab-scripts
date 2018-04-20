% -- Calculo de Variaçao --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

[arquivo] = uigetfile('*.txt', 'Selecione um arquivo');

if isequal(arquivo,0)
    disp('Programa cancelado pelo usuário');
    return;
end

tabela = retornaMatriz(arquivo,5);          % Retorna matriz com elementos do arquivo em cinco colunas

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

fido = fopen('Coeficiente_Variacao_Aresta.txt', 'wt');                                    % Abre arquivo 

fprintf(fido,'%s\t%s\n','INDIV','CVA');   % Imprime cabeçalho da tabela

for i = 1:size(tabela_cva,1)    
    fprintf(fido,'%s\t%g\n',tabela_cva{i,1},tabela_cva{i,2});    %Imprime recursivamente as linhas da tabela         
end

fclose(fido);

fido = fopen('Coeficiente_Variacao_Aglomeracao.txt', 'wt');                                    % Abre arquivo 

fprintf(fido,'%s\t%s\n','INDIV','CVAg');   % Imprime cabeçalho da tabela

for i = 1:size(tabela_cva,1)    
    fprintf(fido,'%s\t%g\n',tabela_cvag{i,1},tabela_cvag{i,2});    %Imprime recursivamente as linhas da tabela         
end

fclose(fido);



