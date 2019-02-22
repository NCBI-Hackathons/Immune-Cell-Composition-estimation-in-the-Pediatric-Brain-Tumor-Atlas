FROM debian:jessie

ENV TZ American/Los_Angeles

RUN apt-get update && apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    libssh2-1-dev \
    libxml2-dev \
    libnetcdf-dev

# Setup Data Volume
VOLUME ["/data"]

# Copy the current directory contents into /myscripts 
#COPY . /usr/local/src/myscripts

# Set the working directory to /myscripts
WORKDIR /usr/local/src/app

# Official R runtime
#FROM r-base:3.5.2
FROM rocker/tidyverse:3.5.2

# Install knitr and required dependencies
RUN Rscript -e "install.packages('knitr', version = '1.21')"

# Install tidyverse and required dependencies
RUN Rscript -e "install.packages('tidyverse')"

# Install ggplot2
RUN Rscript -e "install.packages('ggplot2', version = '3.1.0')"

# Install ggpubr
RUN Rscript -e "install.packages('ggpubr', version = '0.2')"

# Install devtools
RUN Rscript -e "install.packages('devtools', version = '2.0.1')"

# Install BiocManager
ARG CACHEBUST=1
RUN Rscript -e "install.packages('BiocManager', version = '1.30.4')"

# Install BiocManager additionals
RUN Rscript -e "BiocManager::install('GSEABase', version = '3.8')"
RUN Rscript -e "BiocManager::install('GSVA', version = '3.8')"

# Install OptParse

RUN Rscript -e "install.packages('optparse', version = '1.6.1')"

# Install devtools additionals
RUN Rscript -e "devtools::install_github('dviraran/xCell')"

# Install imsig
RUN Rscript -e "install.packages('imsig', version = '1.0.0')"


#### Additional examples below this line.
# Uncomment and update the line below for runnning Rscripts
# CMD ["Rscript", "myscript.R"]

# Install R Package from GitHub
#RUN Rscript -e "install_github('dviraran/xCell')"

# Install R Package from CRAN
#RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
#RUN Rscript -e "install.packages('yhatr')"