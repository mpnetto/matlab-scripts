%% BootStrap
% Autor: Marcos Netto
%
% email: mpnetto88@gmail.com

%% Calculo de BootStrap
% O bootstrap � utilizado para comparar uma amostragem pequena
% com uma amostragem grande. Neste BootStrap, � estipulado tamanho fixo de
% repeticoes para gerar as amostras aleatorias que ser�o comparadas.
%

%%
%%
% *Indica os arquivos e retorna a matriz de duas colunas com os indices e valores*
                     
controle = retornaMatriz( 'Selecione um documento Controle');     
demencia = retornaMatriz( 'Selecione um documento Demencia');

%% 
tabela_indices = [];                    % Cria tabela de incices vazia
tamanho_controle = length(controle);    % Tamanho da tabela da primeira amostra
tamanho_demencia = length(demencia);    % Tamanho da tabela da segunda amostra
total_amostras = 0;                         % Contador de total de amostras
amostras_significantemente_diferentes = 0;  % Contador de amostras significantemente diferentes
tabela_medias = [];                     % Cria uma tabela para poder salvar os valores das medias e do p valor;    
repeticoes = 1000;                      % Estipul a quantidade de repeticoes

%% 
% Em cada itera��o do la�o, s�o realizado os seguintes passos
% - � coletado uma amostra aleat�ria de demencia com a mesma quantidade de
% individuos de controle.
% - S�o salvos os indices da amostra de demencia e adicionados no vetor de
% tabela indice. Os valores duplicados s�o apagados
% - S�o selecionados apenas os valores de controle e demencia e salvos em
% suas respectivas variaveis
% - Compara os valores de controle e demencia atrav�s do TTest e salva na
% vari�vel p.

while (total_amostras < repeticoes)

    [amostra_demencia,indices] = datasample(demencia,tamanho_controle,'Replace',false);
    
    compara_indice = ismember(tabela_indices,indices);
    
    if((any(all(compara_indice,2)))==0)
        tabela_indices = cat(1,indices,tabela_indices);
    
        valores_controle = str2double(controle(:,2));
        valores_demencia = str2double(amostra_demencia(:,2));

        [h,p] = ttest(valores_controle, valores_demencia);

        total_amostras = total_amostras+1;

        if(p<0.05)
            tabela_medias = vertcat(horzcat(mean(valores_controle),mean(valores_demencia), p),tabela_medias);
            amostras_significantemente_diferentes = amostras_significantemente_diferentes+1;
        end
    end
end

resultado = amostras_significantemente_diferentes/total_amostras;

fido = fopen('BootStrap - CVAg.txt', 'wt');
fprintf(fido,'%s\t%s\t%s\t\n','ASD','TA','Result');
fprintf(fido,'%g\t%g\t%g\n',amostras_significantemente_diferentes, total_amostras, resultado);  
fclose(fido);
