# Official R runtime
FROM r-base

# Copy the current directory contents into /myscripts 
COPY . /usr/local/src/myscripts

# Set the working directory to /myscripts
WORKDIR /usr/local/src/myscripts

# Install knitr and required dependencies
RUN Rscript -e "install.packages('knitr', dependencies = TRUE)"

# Install tidyverse and required dependencies
RUN Rscript -e "install.packages('tidyverse', dependencies = TRUE)"

# Install ggplot2
RUN Rscript -e "install.packages('ggplot2', dependencies = TRUE)"




#### Additional examples below this line.
# Uncomment and update the line below for runnning Rscripts
# CMD ["Rscript", "myscript.R"]

# Install R Package from GitHub
#RUN Rscript -e "install_github('dviraran/xCell')"

# Install R Package from CRAN
#RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
#RUN Rscript -e "install.packages('yhatr')"