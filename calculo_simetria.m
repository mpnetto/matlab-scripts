% -- Calculo de Simetria --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

tabela_Mkp = {};                                % Cria Tabela das medias do grau ponderado
soma_Mkp = 0;                                   % Contador da soma das medias        

arquivos = dir('*iREA_MoS.txt');                % Pega todos os arquivos iREA
tamArquivos = length(arquivos);                 % Tamanho do array de arquivos

for i = 1 : tamArquivos
    arquivo = arquivos(i).name;                 % Retorna nome de arquivo atual
 
    tabela = retornaMatriz('', arquivo);        % Retorna matriz com elementos do arquivo
    
    linha_cabecalho = tabela(1,:);              % Salva os valores de cabecalho
        
    tabela(1,:) = [];                           % Remove a linha de indices
    
    eIndex = str2double(tabela(:,9));               % Retorna a coluna com os valores de grau ponderado
    
    eIndex(isnan(eIndex)) = [];
    
    MeIndex = sum(eIndex);                             % Retorna a media dos valores do grau ponderado
        
    tabela_Mkp(end+1,:) = {arquivo, MeIndex};       % Para cada arquivo, salva os valores da media do grau ponderado
    
    soma_Mkp = soma_Mkp + MeIndex;                  % Soma todas as medias do grau ponderado
    
end

caminho = pwd;                      % Pega caminho diretorio atual
diretorio = strsplit(caminho, '\'); % Divide o caminho em arrays com os nomes dos diretorios
tipo = diretorio{end};              % Pega o nome do diretorio atual
nomeArquivo1 = strcat(tipo,'-','Tabela_Simetria.txt'); % Gera nome do arquivo
nomeArquivo2 = strcat(tipo,'-','Tabela_Simetria.txt'); % Gera nome do arquivo

tabela_Mkp = cell2table(tabela_Mkp);
tabela_Mkp.Properties.VariableNames = {'Arquivo','Mkp'};

writetable(tabela_Mkp,nomeArquivo1,'Delimiter','\t') 

Mkp_All = soma_Mkp / tamArquivos;               % Retorna media das somas dos graus ponderados de todos os arquivos

%fido = fopen(nomeArquivo2, 'wt');
%fprintf(fido,'%s\t%g\n','Media Ponderada',Mkp_All); 
%fclose(fido);
