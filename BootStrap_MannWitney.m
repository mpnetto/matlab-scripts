%% BootStrap Mann Witney
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
% 

%% Calculo de BootStrap
% O bootstrap é utilizado para comparar uma amostragem pequena
% com uma amostragem grande. Neste BootStrap, é estipulado tamanho fixo de
% repeticoes para gerar as amostras aleatorias que serão comparadas.

%% Teste T
% É um teste paramétrico para testar a hipotese nula entre duas amostras
% independentes. A distribuição das duas amostras tem que ser normais

%% Modo de Usar
% O programa pode ser rodado em quaisquer dois arquivos de texto que tenham duas
% colunas, uma para os indices e outras para os valores

%% Scripts e documentos necessários
% * lerArquivo.m

controle = lerArquivo( 'Selecione um documento Controle');     
demencia = lerArquivo( 'Selecione um documento Demencia');

%Removes a primeira coluna de indices
controle(1,:) = [];                          
demencia(1,:) = [];

%
tabela_indices = [];

% Retorna tamanho da tabeladas amostras
tamanho_controle = length(controle);
tamanho_demencia = length(demencia);

% Zerando contadores
total_amostras = 0;
amostras_significantemente_diferentes = 0;

% Cria uma tabela para poder salvar os valores das medias e do p valor;
tabela_medias = [];

% Estipula a quantidade de repeticoes
repeticoes = 1000;                      

%% 
% Em cada iteração do laço, são realizado os seguintes passos
% - É coletado uma amostra aleatória de demencia com a mesma quantidade de
% individuos de controle.
% - São salvos os indices da amostra de demencia e adicionados no vetor de
% tabela indice. Os valores duplicados são apagados
% - São selecionados apenas os valores de controle e demencia e salvos em
% suas respectivas variaveis
% - Compara os valores de controle e demencia através do TTest e salva na
% variável p.

while (total_amostras < repeticoes)

    [amostra_demencia,indices] = datasample(demencia,tamanho_controle,'Replace',false);
    
    indices = sort(indices);
    
    compara_indice = ismember(tabela_indices,indices);
    
    if((any(all(compara_indice,2)))==0)
        tabela_indices = cat(1,indices,tabela_indices);
    
        valores_controle = str2double(controle(:,2));
        valores_demencia = str2double(amostra_demencia(:,2));
        
        valores_controle = valores_controle;

        [h,p] = ttest2( valores_demencia, valores_controle);

        total_amostras = total_amostras+1;
        
        tabela_medias = vertcat(horzcat(mean(valores_controle),mean(valores_demencia), p),tabela_medias);

        if(p<0.05)
            amostras_significantemente_diferentes = amostras_significantemente_diferentes+1;
        end
    end
end

%%
% Salva os resultados em um arquivo de texto

resultado = amostras_significantemente_diferentes/total_amostras;

nomeArquivo = uiputfile('.txt','BootStrap - Teste T', 'BootStrap - Teste T');

fido = fopen(nomeArquivo, 'wt');
fprintf(fido,'%s\t%s\t%s\t\n','ASD','TA','Result');
fprintf(fido,'%g\t%g\t%g\n',amostras_significantemente_diferentes, total_amostras, resultado);  
fclose(fido);
