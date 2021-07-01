# procemiento de bases
# se debe bajar de la pagina  los datos de la serie de manera manual mientras 
# se  investiga como hacer este proceso de manera automatica
#   https://www.investing.com/
# serires a trabajar
# soja contrato Mayo 2021
# Futuros aceite de soja EE.UU. - May 2021 (ZLK1)
url10="https://es.investing.com/commodities/us-soybean-oil-historical-data"
# importar los ultimos datos
#-------------------------------------------------------------------------------
importar.data=function(urlx){
  data.x = urlx %>% read_html() %>%
    html_nodes(xpath = '//*[@id="results_box"]/table[1]') %>% 
    html_table()
  data.x <- as.data.frame(data.x)
}
#-----------------------------------------------------------------------------
# 27 observaciones 7 variables
# se debe arregar la data para pegarla con la base historica

#data1=importar.data(url1)
data1=importar.data(url10)
#------------------------------------------------------------------------------
# arreglo de las base
arreglo=function(file1){
names(file1)=c("Fecha","cierre","apertura","max","min","vol","var")
file1$Fecha=dmy(file1$Fecha)
file1$cierre=as.numeric(gsub(",", ".", file1$cierre))
file1$apertura=as.numeric(gsub(",", ".", file1$apertura))
file1$max=as.numeric(gsub(",", ".", file1$max))
file1$min=as.numeric(gsub(",", ".", file1$min))

file1$vol=gsub(",", ".", file1$vol)
file1$vol=gsub("K", "", file1$vol)
file1$vol=as.numeric(file1$vol)

file1$var=gsub(",", ".", file1$var)
file1$var=gsub("%", "", file1$var)
file1$var=as.numeric(file1$var)
return(file1)
}
#------------------------------------------------------------------------------
data1=arreglo(data1)
#data2=arreglo(data1) 
url2="data/Datos históricos Futuros aceite de soja EE.UU.csv"
data2=read_csv(url2)
data2=arreglo(data2)
data2$cierre=data2$cierre/100
data2$max=data2$max/100
data2$min=data2$min/100
#-------------------------------------------------------------------------------
# pegada de datos  data1 y data2
data.soya=distinct(rbind(data1,data2)) # pega los dos archivos
data.soya=distinct(data.soya)
url11="data/data.soya.csv"
write_csv(data.soya,url11)
#--------------------------------------------------------------------------------
