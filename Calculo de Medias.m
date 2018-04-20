% -- Calculo de Médias e Retiradas de Arestas 0 --
%Autor: Marcos Netto
%email: mpnetto88@gmail.com

Table = {};                         % Cria Tabela que vai conteras informaçõs que serão 

files = dir('*iTime_MoS.txt');      % Pega todos os arquivos iTime
nfiles = length(files);             % Tamanho do array de arquivos
    
for i = 1 : nfiles
    arq = files(i).name;            % nome do arquivo individual
    fidi = fopen(arq);              % abre o arquvio
 
    Glxc  = textscan(fidi, '%s', 'Delimiter','\t','HeaderLines',1);     %Salva tabela do arquio em uma array
    frewind(fidi)
    Glxcs = textscan(fidi, '%s', 'Delimiter','\r\n','HeaderLines',1);   % Salva tabela do arquivo em uma matriz
    fclose(fidi);                                                       % Fecha Arquivo
    
    dlen = 3*fix(length(Glxc{:})/3);                                    % Define Tamanho do arquivo transformado em atriz de 3 colunas                           
    Glxcr = reshape(Glxc{:}(1:dlen), 3, [])';                           % Transforma array em matriz de 3 colunas           
    Idx = cellfun(@(x) str2num(x) > 0, Glxcr(:,2), 'Uni',0);            % Pega apenas as linhas cuja aresta seja maior que 0
    LIdx = logical(cell2mat(Idx));                                      % Pega o array de tranformacao logica da função acima                     
    NewGlxc = Glxcs{:}(LIdx,:);                                         % Nova tabela com todas as arestas acima de 0

    %fido = fopen(arq,'wt')        % Caso queira salvar a tabela sem as arestas 0
    %fprintf(fido, '%s\n', NewGlxc{:});
    %fclose(fido)

    A =cellfun(@strsplit,NewGlxc, 'Uni',0);                             % Transforma as informacoes da tabela
    B = table2array(cell2table(A));                                     % Transforma tabelaem array
    C = B(:,2);                                                         % Pega a coluna das arestas
    D = B(:,3);                                                         % Pega a coluna dos cc

    for i = 1:length(C)
       ED(i) = str2num(cell2mat(C(i)));                                 % Transforma os valores das arestas em numeros
    end

    for i = 1:length(D)
       CC(i) = str2num(cell2mat(D(i)));                                 % Transforma os valores do cc em numeros
    end

    mne = mean(ED);                                                     % Calcula Media das arestas
    mcc = mean(CC);                                                     % Calcula media dos ccs

    stne = std(ED);                                                     % Calcula desvio padrão das arestas
    stcc = std(CC);                                                     % Calcula desvio padrãodos cc's
    
    Table(end+1,:) = {arq,mne,mcc,stne,stcc};                           % Para cada arquivo, salva os valores acima para tabela

end

%disp(Table);   %Imprime Tabela
    
fido = fopen('Tabela_Medias_Controle.txt', 'wt');                           % Abre arquivo 

fprintf(fido,'%s\t%s\t%s\t%s\t%s\n','Arquivo','MNE','MCC','STNE','STCC');   % Imprime cabeçalho da tabela

for i = 1:size(Table,1)    
    fprintf(fido,'%s\t%g\t%g\t%g\t%g\n',Table{i,1},Table{i,2},Table{i,3},Table{i,4},Table{i,5});    %Imprime recursivamente as linhas da tabela 
        
end
fclose(fido);                                                               %Fecha arquivo
