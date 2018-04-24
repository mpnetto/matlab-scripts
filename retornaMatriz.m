%% RetornaMatriz
% Autor: Marcos Netto
%
% email: mpnetto88@gmail.com

%% Retorna Conteudo de arquivo
% Ler conteudo dentro de um arquivo e retorna em formato de matrix
%

function matriz = retornaMatriz(txt)

    [arquivo] = uigetfile('*.txt', txt);    % Abre caixa de seleção para arquivo de texto

    if isequal(arquivo,0)
        disp('Programa cancelado pelo usuário');
        return;
    end

    fac = fopen(arquivo);                   % Abre Arquivo
    cabecalho = fgets(fac);                 % Pega o conteudo do cabeçalho
    delimiter = char(9);                    % Estipula delimitador (Nesse caso o tab)
    cols = numel(strfind(cabecalho,delimiter)) + 1;   % Pega a quantidade de Colundas
    conteudo  = textscan(fac, '%s', 'Delimiter',delimiter);    % Pega todo o conteudo do arquivo e coloca em um array
    frewind(fac);                           % Libera o ponteiro
    fclose(fac);                            % Fecha o arquvio

    len = cols*fix(length(conteudo{:})/cols);   %pega o tamanho do array que contem o conteudo do arquivo                                
    matriz = reshape(conteudo{:}(1:len), cols, [])';    % Redimensiona o array em uma matriz com numero de colunas correspondentes do arquivo
end