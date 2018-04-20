function matriz = retornaMatriz(arq, tam)
fac = fopen(arq);              
content  = textscan(fac, '%s', 'Delimiter','\t','HeaderLines',1);    
frewind(fac);
fclose(fac);    
len = tam*fix(length(content{:})/tam);                                
matriz = reshape(content{:}(1:len), tam, [])';  
end