# tratamento-de-series-temporais

Tratamento de intervalos de tempo (de horário para diário) e separação de múltiplas séries temporais presentes num único arquivo.

Dados de entrada esperados nesse script: http://www2.cemaden.gov.br/mapainterativo/# -> Download de dados -> Estações Hidrológicas\
Deve aparecer a janela "Download - Dados de PCDs Hidrológicas" (layout de 29 de agosto de 2022)

O script "tratar_cemaden.R" está pronto para receber dados de precipitação provenientes do CEMADEN (como disponibilizado em 29 de agosto de 2022).\
Exemplos:\
O arquivo "ara-04-2022.csv" é um típico arquivo de entrada esperado.\
Os demais arquivos .csv são típicas saídas.

Para ser utilizado puramente como está aqui, os DADOS DE ENTRADA devem ter as seguintes características:\
      intervalo de medição na escala até horas,\
      várias estações no mesmo município (opcional),\
      formato .csv,\
      as colunas devem ser: **municipio;codEstacao;uf;nomeEstacao;latitude;longitude;datahora;valorMedida**\
      a coluna datahora deve conter valores na seguinte formatação: _aaaa-MM-dd_. Tudo após -dd é ignorado.
      
Resultado: arquivos .csv com somas diárias de precipitação de cada estação presente na cidade, com colunas separadas por ; e decimal após ,\
Cada arquivo vai conter acumulados diários de uma estação diferente (se houver) em um mês.

**Adaptações necessárias em cada rodada:**\
1 - O endereço e formatação dos arquivos de entrada nas primeiras linhas\
(separador, decimal e nome do mês, quando necessários)\
*abril <- read.csv(sprintf("%s/ara-04-2022.csv", getwd()),\
                       sep = ";",\
                       dec = ",")*
                       
2 - O endereço de saída perto do final da função diarize():\
*write.csv2(...\
              file = sprintf("%s-%s-diario-aracaju-2022.csv", fator, substr(fatordata, 1, 7)),\
              ...\
              )*
              
Não esquecer de rodar a função no seu mês ao final ;)
