% -- Calculo de Médias e Retiradas de Arestas 0 --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

tabela_medias = {};                             % Cria Tabela que vai conteras informaçõs que serão

arquivos = dir('*iTime_MoS.txt');               % Pega todos os arquivos iTime
tamArquivos = length(arquivos);                 % Tamanho do array de arquivos

for i = 1 : tamArquivos
    arquivo = arquivos(i).name;                 % Retorna nome de arquivo atual
 
    tabela = retornaMatriz(arquivo,3);          % Retorna matriz com elementos do arquivo em tres colunas

    valores_tabela = str2double(tabela);        % Transforma os valores da matriz para double
    %valores_tabela(valores_tabela(:, 2)== 0, :)=[];     %Retorna apenas as linhas cuja o valor da aresta (segunda coluna) nao seja 0.
    
    arestas = valores_tabela(:,2);              % Pega a coluna das arestas
    aglomeracao = valores_tabela(:,3);          % Pega a coluna dos coeficientes de aglomeraçào

    mne = mean(arestas);                         % Calcula Media das arestas
    mcc = mean(aglomeracao);                     % Calcula media dos ccs

    stne = std(arestas);                         % Calcula desvio padrão das arestas
    stcc = std(aglomeracao);                     % Calcula desvio padrãodos cc's

    tabela_medias(end+1,:) = {arquivo,mne,mcc,stne,stcc};   % Para cada arquivo, salva os valores acima para tabela
end

fido = fopen('Tabela_Medias_Demencia_zero.txt', 'wt');                           % Abre arquivo 

fprintf(fido,'%s\t%s\t%s\t%s\t%s\n','Arquivo','MNE','MCC','STNE','STCC');   % Imprime cabeçalho da tabela

for i = 1:size(tabela_medias,1)    
    fprintf(fido,'%s\t%g\t%g\t%g\t%g\n',tabela_medias{i,1},tabela_medias{i,2},tabela_medias{i,3},tabela_medias{i,4},tabela_medias{i,5});    %Imprime recursivamente as linhas da tabela         
end

fclose(fido);                                                               %Fecha arquivo
