# Official R runtime
FROM r-base

# Copy the current directory contents into /myscripts 
COPY . /usr/local/src/myscripts

# Set the working directory to /myscripts
WORKDIR /usr/local/src/myscripts

# Uncomment and update the line below for runnning Rscripts
# CMD ["Rscript", "myscript.R"]

# Install R Package from GitHub
#RUN Rscript -e "install_github('dviraran/xCell')"

# Install R Package from CRAN
#RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
#RUN Rscript -e "install.packages('yhatr')"