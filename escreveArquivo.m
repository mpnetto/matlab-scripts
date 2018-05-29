%% Escreve Arquivo
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
%% Escreve Conteudo em arquivo
% Recebe conteudo em formato de tabela e escreve em arquivo

function escreveArquivo(tabela,cabecalho, nome, ext)

     nomeArquivo = uiputfile(ext,nome,nome);

     tabela.Properties.VariableNames = cabecalho;

     writetable(tabela,nomeArquivo,'Delimiter','\t')
end