library("optparse")
library("imsig")

option_list = list(
  make_option(c("-i", "--input"), type="character", default=NULL,
              help="dataset file name", metavar="in.txt"),
  make_option(c("-o", "--out"), type="character", default=NULL, 
              help="output file name", metavar="out.txt")
);

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

if (is.null(opt$input) || is.null(opt$out)){
  print_help(opt_parser)
  stop("Input and output must be supplied", call.=FALSE)
}

exp = read.table(opt$input, header = T, row.names = 1, sep = '\t')
plot_abundance(exp = exp, r = 0.7)
output <- imsig(exp = exp, r = 0.7)
write.table(output, opt$out, sep="\t", row.names=T)
