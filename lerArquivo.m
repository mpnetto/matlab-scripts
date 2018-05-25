%% Ler Arquivo
% 
%  Autor: Marcos Netto
%  Email: mpnetto88@gmail.com
%% Retorna Conteudo de arquivo
% Ler conteudo dentro de um arquivo e retorna em formato de matrix

function matriz = lerArquivo(txt, arquivo)

     if ~exist('arquivo','var')
         [arquivo] = uigetfile('*.txt', txt);    % Abre caixa de seleção para arquivo de texto

        if isequal(arquivo,0)
            disp('Programa cancelado pelo usuário');
            return;
        end
     end

    % Abre Arquivo
    fac = fopen(arquivo);
    
    % Pega o conteudo do cabeçalho
    cabecalho = fgets(fac);
    
    % Retorna ponteiro a posicao inicial
    frewind(fac);
    
    % Estipula delimitador (Nesse caso o tab)
    delimiter = char(9);
    
    % Pega a quantidade de Colunas
    cols = numel(strfind(cabecalho,delimiter)) + 1;
    
    % Pega todo o conteudo do arquivo e coloca em um array
    conteudo  = textscan(fac, '%s', 'Delimiter',delimiter);
    
    %Fecha o arquivo
    fclose(fac);

    %pega o tamanho do array que contem o conteudo do arquivo
    len = cols*fix(length(conteudo{:})/cols);
    
    % Redimensiona o array em uma matriz com numero de colunas correspondentes do arquivo
    matriz = reshape(conteudo{:}(1:len), cols, [])';    
end