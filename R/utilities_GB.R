#' Summary table for the output of the MCMC process
#' 
#' Creates a summary table based on tibbles and with some nice
#' formatting properties
#' 
#' @param x A 'jags' object resulting from a call to 'jags(...)'
#' @param parameter A (vector of) parameter(s) name(s) to be displayed in the
#' summary table. If NULL (default), then uses all the model parameters
#' that have been monitored to construct the summary tibble. 
#' @param probs A vector of probability values to be shown to represent the 
#' summary statistics. Defaults to 'c(0.025,0.975)', to show the 2.5 and the 
#' 97.5% percentiles of the posterior distributions (indicating a rough 95%
#' credible interval). Other possible values are 0.25, 0.5, 0.75
#' @param ...  Additional options
#' @author Gianluca Baio
#' @seealso \code{jags}, \code{print.jags}
#' @keywords Summary table
#' @examples
#' \dontrun{ 
#' } 
#' @export jags_summary
#' 
jags_summary=function(x,parameter=NULL,probs=c(.025,.975),...) {
  
  required_packages=c("tidyverse","R2jags")
  for (pkg in required_packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      stop("`", pkg, "` is required: install.packages('", pkg, "')")
    }
  }
  
  all_probs=c("2.5%","25%","50%","75%","97.5%")
  probs=paste0(as.character(probs*100),"%")
  
  if(length(parameter)>1) {
    parameter=paste(parameter,collapse="|")
  }
  
  tab=x$BUGSoutput$summary
  out=tab %>% as_tibble() %>% mutate(Parameter=rownames(tab)) %>% 
    select(-setdiff(all_probs,probs)) %>% 
    select(Parameter,mean,sd,everything())
  if(!is.null(parameter)){
    out=out %>% filter(grepl(parameter,Parameter))
  }
  return(out)
}

#' Specialised diagnostic plots
#' 
#' Creates a plot showing the output of convergence indicators, such as
#' the Potential Scale Reduction and the effective sample size
#' 
#' @param x A 'jags' object resulting from a call to 'jags(...)'
#' @param what A string indicating what diagnostic measure should be plotted.
#' Options are 'Rhat' (default), indicating the PSR statistic, or 'n.eff', 
#' indicating the effective sample size
#' @param ...  Additional options
#' @author Gianluca Baio
#' @seealso \code{jags}
#' @keywords Diagnostic plots
#' @examples
#' \dontrun{ 
#' } 
#' @export jags_diagplot
#' 
jags_diagplot=function(x,what="Rhat",...) {
  
  required_packages=c("tidyverse","R2jags")
  for (pkg in required_packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      stop("`", pkg, "` is required: install.packages('", pkg, "')")
    }
  }
  
  x$BUGSoutput$summary %>% as_tibble() %>% ggplot(aes(1:nrow(.),!!sym(what))) + 
    geom_point() + geom_hline(yintercept=ifelse(what=="Rhat",1.1,m$BUGSoutput$n.sims),linetype="dashed",size=2) + 
    theme_gb() + labs(x="Parameters",title=ifelse(what=="Rhat","Potential scale reduction","Effective sample size"))
}



