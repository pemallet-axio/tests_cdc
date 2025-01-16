FROM rocker/r-ver:3.4.4

RUN mkdir /home/analysis 
RUN mkdir /home/results

#RUN R -e install.packages("plumber")

COPY create_csv.R /home/analysis/create_csv.R 
COPY manipulate_csv.R /home/analysis/manipulate_csv.R

CMD R -e "source('/home/analysis/create_csv.R')" \
    && R -e "source('/home/analysis/manipulate_csv.R')"

