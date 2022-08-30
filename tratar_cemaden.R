# carregar arquivos
abril <- read.csv(sprintf("%s/maceio/maceio-abril-2021.csv", getwd()),
                       sep = ";",
                       dec = ",")
maio <- read.csv(sprintf("%s/maceio/maceio-maio-2021.csv", getwd()),
                      sep = ";",
                      dec = ",")
junho <- read.csv(sprintf("%s/maceio/maceio-junho-2021.csv", getwd()),
                       sep = ";",
                       dec = ",")
julho <- read.csv(sprintf("%s/maceio/maceio-julho-2021.csv", getwd()),
                       sep = ";",
                       dec = ",")

diarize <- function(mes){
  
  # essa seria a saida - terminou não sendo
  # colocar somente as colunas que interessam
  mensal <- data.frame("data" = mes$datahora,
                       "nome" = mes$nomeEstacao,
                       "lat" = mes$latitude,
                       "lon" = mes$longitude,
                       "chuva" = mes$valorMedida)
  mensal$nome <- as.factor(mensal$nome)
  
  # separar, diarizar e salvar dados pelo fator 'nome'
  for (fator in levels(mensal$nome)){
    # todas as colunas das linhas de tal 'fator'
    mensal1 <- mensal[mensal$nome == fator, ]
    
    # agora transformar em dado diario:
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
    # já pode fechar o mes e salvar
    write.csv2(diarios,
              file = sprintf("%s-%s-diario-maceio-2021.csv", fator, substr(fatordata, 1, 7)),
              row.names = F,
              )
    
  }#separou por nome
  
}# diarize()

diarize(abril)
diarize(maio)
diarize(junho)
diarize(julho)
