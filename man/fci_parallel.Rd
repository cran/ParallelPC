% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/ParallelPC.R
\name{fci_parallel}
\alias{fci_parallel}
\title{Estimate a Partial Ancestral Graph using the FCI_parallel algorithm}
\usage{
fci_parallel(suffStat, indepTest, alpha, labels, p,
  skel.method = c("parallel"), mem.efficient = FALSE, type = c("normal",
  "anytime", "adaptive"), fixedGaps = NULL, fixedEdges = NULL,
  NAdelete = TRUE, m.max = Inf, pdsep.max = Inf, rules = rep(TRUE, 10),
  doPdsep = TRUE, biCC = FALSE, conservative = FALSE, maj.rule = FALSE,
  verbose = FALSE, num.cores = detectCores())
}
\arguments{
\item{suffStat}{Sufficient statistics: List containing all necessary elements for the conditional independence decisions in the function indepTest.}

\item{indepTest}{Predefined function for testing conditional independence. The function is internally called as indepTest(x,y,S,suffStat), and tests conditional independence of x and y given S. Here, x and y are variables, and S is a (possibly empty) vector of variables (all variables are denoted by their column numbers in the adjacency matrix). suffStat is a list containing all relevant elements for the conditional independence decisions. The return value of indepTest is the p-value of the test for conditional independence.}

\item{alpha}{Significance level for the individual conditional independence tests.}

\item{labels}{(optional) character vector of variable (or "node") names. Typically preferred to specifying p.}

\item{p}{(optional) number of variables (or nodes). May be specified if labels are not, in which case labels is set to 1:p.}

\item{skel.method}{Character string specifying method; the default, "parallel", uses the parallelised method to build the skeleton of the graph, see skeleton_parallel.}

\item{mem.efficient}{Uses less amount of memory at any time point while running the algorithm.}

\item{type}{Character string specifying the version of the FCI algorithm to be used. By default, it is "normal", and so the normal FCI algorithm is called. If set to "anytime", the 'Anytime FCI' is called and m.max needs to be specified. If set to "adaptive", the 'Adaptive Anytime FCI' is called and m.max is not used. For more information, see Details.}

\item{fixedGaps}{A logical matrix of dimension p*p. If entry [i,j] or [j,i] (or both) are TRUE, the edge i-j is removed before starting the algorithm. Therefore, this edge is guaranteed to be absent in the resulting graph.}

\item{fixedEdges}{A logical matrix of dimension p*p. If entry [i,j] or [j,i] (or both) are TRUE, the edge i-j is never considered for removal. Therefore, this edge is guaranteed to be present in the resulting graph.}

\item{NAdelete}{If indepTest returns NA and this option is TRUE, the corresponding edge is deleted. If this option is FALSE, the edge is not deleted.}

\item{m.max}{Maximum size of the conditioning sets that are considered in the conditional independence tests.}

\item{pdsep.max}{Maximum size of Possible-D-SEP for which subsets are considered as conditioning sets in the conditional independence tests. See pcalg for more details.}

\item{rules}{Logical vector of length 10 indicating which rules should be used when directing edges. See pcalg for more details.}

\item{doPdsep}{If TRUE, Possible-D-SEP is computed for all nodes, and all subsets of Possible-D-SEP are considered as conditioning sets in the conditional independence tests, if not defined otherwise in pdsep.max. If FALSE, Possible-D-SEP is not computed, so that the algorithm simplifies to the Modified PC algorithm of Spirtes, Glymour and Scheines (2000, p.84).}

\item{biCC}{If TRUE, only nodes on paths between nodes x and y are considered to be in Possible-D-SEP(x) when testing independence between x and y. Uses biconnected components, biConnComp from RBGL.}

\item{conservative}{Logical indicating if the unshielded triples should be checked for ambiguity the second time when v-structures are determined.}

\item{maj.rule}{Logical indicating if the unshielded triples should be checked for ambiguity the second time when v-structures are determined using a majority rule idea, which is less strict than the standard conservative. For more information, see details.}

\item{verbose}{If true, more detailed output is provided.}

\item{num.cores}{Numbers of cores CPU to run the algorithm}
}
\value{
An object of class fciAlgo (see fciAlgo in the pcalg package) containing the estimated graph (in the form of an adjacency matrix with various possible edge marks), the conditioning sets that lead to edge removals (sepset) and several other parameters.
}
\description{
Estimate a Partial Ancestral Graph (PAG) from observational data, using the FCI_parallel Algorithm. This is the parallelised version of the FCI algorithm in the pcalg package.
The parameters are consistent with the FCI algorithm in pcalg, except the parameter num.cores for specifying the number of cores CPU.
}
\examples{
##########################################
## Using fci_parallel without mem.efficeient
##########################################
library(pcalg)
library(parallel)
data("gmG")
p<-ncol(gmG$x)
suffStat<-list(C=cor(gmG$x),n=nrow(gmG$x))
fci_parallel(suffStat, indepTest=gaussCItest, p=p, skel.method="parallel", alpha=0.01, num.cores=2)

##########################################
## Using fci_parallel with mem.efficeient
##########################################

suffStat<-list(C=cor(gmG$x),n=nrow(gmG$x))
fci_parallel(suffStat, indepTest=gaussCItest, p=p, skel.method="parallel",
alpha=0.01, num.cores=2, mem.efficient=TRUE)

#################################################
## Using fci_parallel with mutual information test
#################################################
library(pcalg)
library(parallel)
data("gmG")
p<-ncol(gmG$x)
#' # The first parameter is the dataset
fci_parallel(gmG$x, indepTest=mig, p=p, skel.method="parallel",
alpha=0.01, num.cores=2, mem.efficient=TRUE)
}
\references{
1. Diego Colombo, Marloes H Maathuis, Markus Kalisch, Thomas S Richardson, et al. Learning high-dimensional directed acyclic graphs with latent and selection variables. The Annals of Statistics, 40(1):294-321, 2012.

2. Markus Kalisch, Martin Machler, Diego Colombo, Marloes H Maathuis, and Peter Buhlmann. Causal inference using graphical models with the r package pcalg.
 Journal of Statistical Software, 47(11):1-26, 2012.
}

