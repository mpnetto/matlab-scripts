function matriz = retornaMatriz(arq, col)
fac = fopen(arq);              
content  = textscan(fac, '%s', 'Delimiter','\t','HeaderLines',1);    
frewind(fac);
fclose(fac);    
len = col*fix(length(content{:})/col);                                
matriz = reshape(content{:}(1:len), col, [])';  
end