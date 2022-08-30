# tratamento-de-series-temporais

Tratamento de intervalos de tempo e extração de subconjuntos de séries temporais.

O script "tratar_cemaden.R" está pronto para receber dados de precipitação provenientes do CEMADEN (como disponibilizado em 29 de agosto de 2022).

Para ser utilizado puramente como está aqui, os DADOS DE ENTRADA devem ter as seguintes características:\
      intervalo de medição na escala de minutos,\
      várias estações no mesmo município (opcional),\
      formato .csv,\
      as colunas devem ser: **municipio;codEstacao;uf;nomeEstacao;latitude;longitude;datahora;valorMedida**\
      a coluna datahora deve conter valores na seguinte formatação: _aaaa-MM-dd_. Tudo após -dd é ignorado.
      
Resultado: arquivos .csv com somas diárias de precipitação de cada estação presente na cidade, com colunas separadas por ; e decimal após ,\
Cada arquivo vai conter dados de uma estação diferente em um mês diferente.

**Alterações necessárias:**\
O endereço e formatação dos arquivos de entrada nas primeiras linhas\
(separador, decimal e nome do mês, quando necessários)\
*abril <- read.csv(sprintf("%s/maceio/maceio-abril-2021.csv", getwd()),\
                       sep = ";",\
                       dec = ",")*
                       
O endereço de saída perto do final da função diarize():\
*write.csv2(...\
              file = sprintf("%s-%s-diario-maceio-2021.csv", fator, substr(fatordata, 1, 7)),\
              )*
              
Não esquecer de rodar a função no seu mês ao final ;)
