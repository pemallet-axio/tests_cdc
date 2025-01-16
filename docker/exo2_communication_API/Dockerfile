FROM rocker/r-ver:latest

RUN mkdir /home/analysis 
RUN mkdir /home/results

RUN R -e "install.packages(c('plumber', 'readr'))"

COPY plumber0.R /home/analysis/plumber0.R 
COPY run_plumber0.R /home/analysis/run_plumber0.R

EXPOSE 80

CMD ["R", "-e", "source('/home/analysis/run_plumber0.R')"]

#CMD ["R", "-e", "plumber::plumb('/home/analysis/run_plumber0.R')"] 

#$run(host='0.0.0.0', port=80)"]

#CMD R -e "source('/home/analysis/run_plumber0.R')" 
#ENTRYPOINT["Rscript", "/home/analysis/run_plumber0.R"]
