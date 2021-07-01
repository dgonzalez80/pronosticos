# funciones para graficos
#-----------------------------------------------------------------------
# grafico de la serie
grafico1=function(file){
  fig.oil.s1=ggplot(file, aes(x = Fecha, y =cierre)) +
    geom_line(color = "#FC4E07", size = 1)
  ggplotly(fig.oil.s1) 
}

#-----------------------------------------------------------------------
#grafico con tendencia
grafico2=function(file){
  fig.oil.s0=ggplot(file, aes(Fecha, cierre)) + 
    geom_line(color = "#FC4E07", size = .5) +
    geom_smooth(method = "loess", se = FALSE, span = 0.05)
  ggplotly(fig.oil.s0)
}

#-----------------------------------------------------------------------
#grafico con pronosticos arima
grafico3=function(file){
  p.arima1=auto.arima(file$cierre,stepwise = FALSE, approximation = FALSE)
  f.arima1=forecast(p.arima1,h=14,level=95)
  fig.oil.s2=ggplot(file, aes(Fecha, cierre)) + 
    geom_line(color = "#FC4E07", size = .5) +
    geom_line(aes(y=f.arima1$fitted),color = "#00AFBB", size=1) 
  ggplotly(fig.oil.s2)
}
#-------------------------------------------------------------------------------
grafico4=function(data){
  hc <- data %>%
    hchart(
     "line", 
      hcaes(x = Fecha, y = cierre)
   )
  return(hc)
}
#-------------------------------------------------------------------------------
# tabla estimacion semana siguiente
pronosticos1=function(file){
  p.arima1=auto.arima(file$cierre,stepwise = FALSE, approximation = FALSE)
  f.arima1=forecast(p.arima1,h=14,level=c(95))
  knitr::kable(f.arima1$lower, align = "rr")
}
#-----------------------------------------------------------------------

