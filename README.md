# tratamento-de-series-temporais

Tratamento de intervalos de tempo (de minuto a minuto para horário OU diário) e separação de múltiplas séries temporais presentes num único arquivo. Testado em Windows 7 e 11. Ubuntu 20.04.

Dados de entrada esperados nesse script: http://www2.cemaden.gov.br/mapainterativo/# -> Download de dados -> Estações Pluviométricas\

O script "tratar_cemaden.R" está pronto para receber dados de precipitação provenientes do CEMADEN (como disponibilizado em 29 de agosto de 2022).\
Exemplo: o arquivo "ara-04-2022.csv" aí em cima.

### MODO DE USO:
Carregar essa função na sua sessão R:\
> source("C:\\caminho\\de\\windows\\ate\\pasta\\tratar_cemaden.R")

Passar o arquivo .csv para a função e informar se quer saídas em dado horário ou diário:

#### Para horário use horario = TRUE:
> ORDENAR_CEMADEN(endereco = "/home/caminho/de/linux/dados-do-cemaden.csv", horario = T)

Os arquivos terão o nome "<estação>-horario.csv", um para cada estação.\
Onde <estação> é o nome da estação.

#### Para diário use horario = FALSE:
> ORDENAR_CEMADEN(endereco = ""/home/caminho/de/linux/dados-do-cemaden.csv", horario = F)

Os arquivos terão o nome "<estação>-AAAA-MM-diario.csv".\
Onde AAAA é o ano e MM o mês.

Uma mensagem dirá em qual pasta esses arquivos foram salvos.\
Para mudar essa pasta, altere a pasta de trabalho do R:
> setwd("/caminho/para/pastadetrabalho/")
