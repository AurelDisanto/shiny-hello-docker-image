# Image docker source pour notre application shiny
FROM inseefrlab/onyxia-r-minimal:r4.3.2

# Installation des packages R necessaires à l'application
RUN Rscript -e "install.packages(c('shiny'))"

# Copie des fichiers de l'app Shiny dans l'image docker
RUN mkdir ~/ShinyApp
WORKDIR ~/ShinyApp
COPY ./ui.R ui.R
COPY ./server.R server.R

# Definition du port d'accès de l'application
ARG SHINY_PORT=3838
EXPOSE $SHINY_PORT
RUN echo "local({options(shiny.port = ${SHINY_PORT}, shiny.host = '0.0.0.0')})" >> /usr/local/lib/R/etc/Rprofile.site

# Première commande que l'image exécutera quand elle sera lancée par le shinyproxy
CMD ["Rscript", "-e", "shiny::runApp()"]
