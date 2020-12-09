

#' Trace plot of bugs object
#' 
#' Displays a plot of iterations \emph{vs.} sampled values for each variable in
#' the chain, with a separate plot per variable.
#' 
#' 
#' @aliases traceplot traceplot.default traceplot,mcmc.list-method
#' traceplot,rjags-method traceplot,bugs-method
#' @param x A bugs object
#' @param mfrow graphical parameter (see \code{par})
#' @param varname vector of variable names to plot
#' @param match.head matches the variable names by the beginning of the
#' variable names in bugs object
#' @param ask logical; if \code{TRUE}, the user is \emph{ask}ed before each
#' plot, see \code{par(ask=.)}.
#' @param col graphical parameter (see \code{par})
#' @param lty graphical parameter (see \code{par})
#' @param lwd graphical parameter (see \code{par})
#' @param \dots further graphical parameters
#' @author Masanao Yajima \email{yajima@@stat.columbia.edu}.
#' @seealso \code{\link[coda]{densplot}}, \code{\link[coda]{plot.mcmc}},
#' \code{\link[coda]{traceplot}}
#' @keywords hplot
NULL



