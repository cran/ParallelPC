% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/ParallelPC.R
\name{cor2}
\alias{cor2}
\title{The Pearson's correlation test}
\usage{
cor2(x, y, S, suffStat)
}
\arguments{
\item{x,y,S}{It is tested, whether x and y are conditionally independent given the subset S of
the remaining nodes. x, y, S all are integers, corresponding to variable or node
numbers.}

\item{suffStat}{the dataset with rows are samples and columns are variables.}
}
\value{
the p-value of the test.
}
\description{
Linear correlation: Pearson's linear correlation test.
}
\examples{
##########################################
## Using cor2 as a conditional independence test
##########################################
library(pcalg)
library(bnlearn)
data("gmG")
suffStat<-gmG$x
cor2(1,2,3,suffStat)
##Use cor2 with a causal discovery algorithm, e.g. PC
pc_stable(gmG$x, indepTest=cor2, p=ncol(gmG$x), alpha=0.01)
}
\references{
Marco Scutari (2010). Learning Bayesian Networks with the bnlearn R Package. Journal of Statistical Software, 35(3), 1-22.
}

