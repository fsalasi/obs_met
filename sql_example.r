library(RMySQL)

# connect to a database and load some data
con <- dbConnect(RMySQL::MySQL(), host='192.168.1.12', port=3306, dbname='currodb', user='curro', password='3141592654')

# query
query = "SELECT a.fint AS fechahora, a.valor AS tinst, b.VALOR AS tmax, c.valor AS tmin FROM tb_observaciones_aemet a join tb_observaciones_aemet b ON a.fint = b.FINT join tb_observaciones_aemet c  ON a.fint = c.fint WHERE a.indicador = 'ta' AND b.INDICADOR = 'tamax' and c.INDICADOR = 'tamin'"
rs <- dbSendQuery(con, query)
d1 <- dbFetch(rs)      # extract data in chunks of 10 rows
