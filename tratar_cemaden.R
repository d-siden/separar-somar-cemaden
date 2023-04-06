ORDENAR_CEMADEN <- function(endereco, horario=F){
  # carregar arquivo
  mes <- read.csv(file = endereco,
                  sep = ";",
                  dec = ",")
  
  # essa seria a saida - terminou não sendo
  # colocar somente as colunas que interessam
  mensal <- data.frame("data" = mes$datahora,
                       "nome" = paste(mes$nomeEstacao, mes$codEstacao, sep = "_"),
                       "lat" = mes$latitude,
                       "lon" = mes$longitude,
                       "chuva" = mes$valorMedida)
  mensal$nome <- as.factor(mensal$nome)
  
  # separar, diarizar e salvar dados pelo fator 'nome'
  for (fatornome in levels(mensal$nome)){
    # todas as colunas das linhas de tal 'fator'
    mensal1 <- mensal[mensal$nome == fatornome, ]
    
    # agora transformar em dado diario:
    if(horario==FALSE){
      # remover a hora das datas
      mensal1$data <- substr(mensal1$data, 1, 10)
      
      # TRANSFORMANDO EM FACTOR!!!!!!!!!!!!!!
      # I'M A MOTHERFUCKING GENIOUS!!
      mensal1$data <- as.factor(mensal1$data)
      
      # criar dataframe para receber os valores por data
      mensal2 <- data.frame()
      
      # dataframe para receber os valores diarios prontos somados
      diarios <- data.frame()
      # resetar esse dataframe também separa os arquivos pelo fator 'nome'
      
      # separar por fator-data
      for (fatordata in levels(mensal1$data)){
        mensal2 <- mensal1[mensal1$data == fatordata, ]
        
        # primeira linha: define os nomes
        if(nrow(diarios)<1){
          diarios <- data.frame("chuva" = sum(mensal2$chuva))
          diarios <- cbind(diarios, fatordata)
          names(diarios) <- c("chuva", "dia")
        }else{
          # depois sai colando embaixo
          diarios <- rbind(diarios, c(sum(mensal2$chuva), fatordata))
        }# montou o frame de saida
      }# separou por fator-data
      
      # converter chuva em numeric
      diarios$chuva <- as.numeric(diarios$chuva)
      
      # ja pode fechar o mes e salvar
      # salvar no endereço de entrada
      write.csv2(diarios,
                 file = sprintf("%s-%s-diario.csv", fatornome, substr(fatordata, 1, 7)),
                 row.names = F,
      )
    }else{
      #ou transformar em horario:
      
      # resumir a coluna data para apenas dia e hora
      for(dth in 1:nrow(mensal1)){
        mensal1$data[dth] <- strsplit(mensal1$data, split=":")[[dth]][1]
      }
      
      # transformar em factor      
      mensal1$data <- as.factor(mensal1$data)
      
      # criar dataframe para receber os valores por data e hora
      mensal2 <- data.frame()
      
      # dataframe para receber os valores horarios prontos somados
      horarios <- data.frame()
      # resetar esse dataframe tambem separa os arquivos pelo fator 'nome'
      
      # separar por fator-datahora
      for (fatordatahora in levels(mensal1$data)){
        mensal2 <- mensal1[mensal1$data == fatordatahora, ]
        
        # primeira linha: define os nomes
        if(nrow(horarios)<1){
          horarios <- data.frame("chuva" = sum(mensal2$chuva))
          horarios <- cbind(horarios, fatordatahora)
          names(horarios) <- c("chuva", "datahora")
        }else{
          # depois sai colando embaixo
          horarios <- rbind(horarios, c(sum(mensal2$chuva), fatordatahora))
        }# montou o frame de saida
      }# separou por fator-datahora
      
      # converter chuva em numeric
      horarios$chuva <- as.numeric(horarios$chuva)
      
      # ja pode fechar o mes e salvar
      # salvar no endereço de entrada
      write.csv2(horarios,
                 file = sprintf("%s-horario.csv", fatornome),
                 row.names = F,
      )
    }  # horario
  }  # separou por nome
  cat("Arquivos salvos em:", getwd())
}
