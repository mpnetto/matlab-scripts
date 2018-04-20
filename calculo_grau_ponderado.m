% -- Calculo de Grau Ponderado --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

tabela_Mkp = {};                             % Cria Tabela que vai conteras informaçõs que serão
soma_Mkp = 0;

arquivos = dir('*iREA_MoS.txt');               % Pega todos os arquivos iTime
tamArquivos = length(arquivos);                 % Tamanho do array de arquivos

for i = 1 : tamArquivos
    arquivo = arquivos(i).name;                 % Retorna nome de arquivo atual
 
    tabela = retornaMatriz(arquivo,9);          % Retorna matriz com elementos do arquivo em tres colunas
    
    kp = str2double(tabela(:,4));               % Remove a coluna de indices
    
    Mkp = mean(kp);
    
    soma_Mkp = soma_Mkp + Mkp;
    
    tabela_Mkp(end+1,:) = {arquivo, Mkp};   % Para cada arquivo, salva os valores acima para tabela
    
end

fido = fopen('SEG03_ASC - Controle - Tabela_Media_Ponderada.txt', 'wt');                                    % Abre arquivo 

fprintf(fido,'%s\t%s\t\n','Arquivo','Mkp');   % Imprime cabeçalho da tabela

for i = 1:size(tabela_Mkp,1)    
    fprintf(fido,'%s\t%g\n',tabela_Mkp{i,1},tabela_Mkp{i,2});    %Imprime recursivamente as linhas da tabela         
end

fclose(fido);

Mkp_All = soma_Mkp / tamArquivos;

fido = fopen('SEG03_ASC - Controle - Media_Ponderada.txt', 'wt');
fprintf(fido,'%s\t%g\n','Media Ponderada',Mkp_All); 
fclose(fido);
