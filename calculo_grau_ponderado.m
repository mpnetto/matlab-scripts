%% Grau Ponderado
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
% 

%% Calculo do Grau Ponderado
% O calculo do Grau Ponderado calcula a média do grau ponderado de cada
% individuo. Uma tabela com todos as médias dos individuos é salva em um
% arquivo de texto

% Cria Tabela das medias do grau ponderado
tabela_Mkp = {};

% Retorna todos os arquivos que contem iREA_MoS.txt no nome do arquivo
arquivos = dir('*iREA_MoS.txt');
tamArquivos = length(arquivos);

for i = 1 : tamArquivos
    % Retorna nome do arquivo
    arquivo = arquivos(i).name;
 
    % Retorna conteudo do arquivo em forma de tabela
    tabela = lerArquivo('', arquivo);
    
    % Removecabecalhoy           
    tabela(1,:) = [];
    
    % Retorna a coluna com os valores de grau ponderado e calcula a média e
    % salva na tabela
    kp = str2double(tabela(:,4));               
    Mkp = mean(kp);
    tabela_Mkp(end+1,:) = {arquivo, Mkp};    
     
end

cabecalho = {'Arquivo','Mkp'};

tabela_Mkp = cell2table(tabela_Mkp);
escreveArquivo(tabela_Mkp,cabecalho,'Tabela Media Ponderada', '.txt');

