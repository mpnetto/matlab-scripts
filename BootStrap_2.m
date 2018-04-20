%% BootStrap
% Autor: Marcos Netto
%
% email: mpnetto88@gmail.com

%% Calculo de BootStrap
% O bootstrap é utilizado para comparar uma amostragem pequena
% com uma amostragem grande. 
%

%%
%%
% *Indica os arquivos e retorna a matriz de duas colunas com os indices e valores*

[arquivo_controle] = uigetfile('*.txt', 'Selecione um documento Controle');

if isequal(arquivo_controle,0)
    disp('Programa cancelado pelo usuário');
    return;
end

[arquivo_demencia] = uigetfile('*.txt', 'Selecione um documento Demencia');

if isequal(arquivo_demencia,0)
    disp('Programa cancelado pelo usuário');
    return;
end
                     
controle = retornaMatriz(arquivo_controle,2);     
demencia = retornaMatriz(arquivo_demencia,2);

%% 
% Cria uma tabela vazia para conter os indices e atribui tamanho das
% matrizes de controle e demencia.
tabela_indices = [];
tamanho_controle = length(controle);
tamanho_demencia = length(demencia);
total_amostras = 0;
amostras_significantemente_diferentes = 0;
tabela_medias = [];

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
%%while length(tabela_indices) < tamanho_demencia

while (total_amostras < 1000)

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
