library(RMySQL)
library(stringr)

# connect to the database
con <- dbConnect(RMySQL::MySQL(), host='192.168.1.12', port=3306, dbname='currodb', user='curro', password='3141592654')

# query
start_date = "2020-05-15d"
end_date = "2020-05-18"
query = paste("SELECT a.fint AS fechahora, a.valor AS tinst, b.VALOR AS tmax, c.valor AS tmin ",
              "FROM tb_observaciones_aemet a join tb_observaciones_aemet b ON a.fint = b.FINT ",
              "join tb_observaciones_aemet c  ON a.fint = c.fint ",
              "WHERE a.indicador = 'ta' AND b.INDICADOR = 'tamax' and c.INDICADOR = 'tamin' ",
              "AND date(a.fint) BETWEEN '%FI%' AND '%FF%';")
query = str_replace(query, "%FI%", start_date)
query = str_replace(query, "%FF%", end_date)

rs <- dbSendQuery(con, query)
data <- dbFetch(rs)

# clear the environment non important variables and data
rm(end_date)
rm(start_date)
rm(query)
rm(con)
rm(rs)
