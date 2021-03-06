#' Function to visualize p-values from HiCcompare results
#' 
#' @param hic.table A hic.table object that has been
#'     normalized and has had differences detected.
#' @param alpha The alpha level at which you will 
#'     call a p-value significant. If this is set to
#'     a numeric value then any p-values >= alpha will
#'     be set to 1 for the visualization in the heatmap.
#'     Defaults to NA for visualization of all p-values.
#' @param adj.p Logical, Should the multiple testing
#'     corrected p-values be used (TRUE) or the raw 
#'     p-values (FALSE)?
#' @details The goal of this function is to visualize
#'     where in the Hi-C matrix the differences are
#'     occuring between two experimental conditions.
#'     The function will produce a heatmap of the
#'     -log10(p-values) * sign(adj.M) 
#'     to visualize where the
#'     significant differences between the datasets
#'     are occuring on the genome. 
#' @return A heatmap
#' @examples 
#' # Create hic.table object using included Hi-C data in sparse upper triangular
#' # matrix format
#' data('HMEC.chr22')
#' data('NHEK.chr22')
#' hic.table <- create.hic.table(HMEC.chr22, NHEK.chr22, chr = 'chr22')
#' # Plug hic.table into hic_loess()
#' result <- hic_loess(hic.table, Plot = TRUE)
#' # perform difference detection
#' diff.result <- hic_compare(result, Plot = TRUE)
#' # visualize p-values
#' visualize_pvals(diff.result)
#' @export

visualize_pvals <- function(hic.table, alpha = NA, adj.p = TRUE) {
  # check that hic.table is entered
  if (!is(hic.table, "data.table")) {
    stop("Enter a hic.table object")
  }
  # check that hic.table has necessary columns
  if (ncol(hic.table) < 16) {
    stop('Enter a hic.table that you have already performed normalization and difference detection on')
  }
  if (!is.na(alpha)) {
    if (!is.numeric(alpha)) {
      stop("Alpha must be a numeric value between 0 and 1")
    }
    if (alpha < 0 | alpha > 1) {
      stop("Alpha must be a numeric value between 0 and 1")
    }
  }
  # convert to full matrix
  if (adj.p) {
    m <- sparse2full(hic.table, hic.table = TRUE, column.name = 'p.adj') 
  } else {
    m <- sparse2full(hic.table, hic.table = TRUE, column.name = 'p.value') 
  }
  
  # get fold change
  fc <- sparse2full(hic.table, hic.table = TRUE, column.name = 'adj.M')
  # remove non significant values from matrix if alpha is set to a value
  if (!is.na(alpha)) {
    m[m >= alpha] <- 1
  }
  # plot heatmap
  pheatmap::pheatmap(-log10(m) * sign(fc), cluster_rows = FALSE, 
                     cluster_cols = FALSE, show_rownames = FALSE, 
                     show_colnames = FALSE)
  # # get TADs
  # m2 <- sparse2full(hic.table, hic.table = TRUE, column.name = 'IF1') 
  # tads <- HiCseg::HiCseg_linkC_R(size_mat = nrow(m2), nb_change_max = round(nrow(m2) / 5) + 1, distrib = "B", mat_data = m2, model = "Dplus")
  # image(1:nrow(m2), 1:nrow(m2), -log10(m)*sign(fc), xlab="", ylab="")
  # t_hat=c(1,tads$t_hat[tads$t_hat!=0]+1)
  # for (i in 1:(length(t_hat)-1)) {
  #   lines(c(t_hat[i],t_hat[i]),c(t_hat[i],(t_hat[(i+1)]-1)))
  #   lines(c(t_hat[(i+1)]-1,t_hat[(i+1)]-1),c(t_hat[i],t_hat[(i+1)]-1))
  #   lines(c(t_hat[i],t_hat[(i+1)]-1),c(t_hat[i],t_hat[i]))
  #   lines(c(t_hat[i],t_hat[(i+1)]-1),c(t_hat[(i+1)]-1,t_hat[(i+1)]-1))
  # }
  # 
  # library(ComplexHeatmap)
  # mat <- -log10(m) * sign(fc)
  # Heatmap(mat, name = "pval", cluster_rows = FALSE, cluster_columns = FALSE)
  # decorate_heatmap_body("pval", {
  #   # i = t_hat[i]
  #   # x = i/ncol(mat)
  #   # grid.lines(c(x,x), c(0,1), gp=gpar(lwd=2))
  #   for (i in 1:(length(t_hat)-1)) {
  #     i = t_hat[i]
  #     x = i/ncol(mat)
  #     y = t_hat[(i+1)]-1
  #     y = y/ ncol(mat)
  #     grid.lines(x = c(x,x), y = c(x,y))
  #     grid.lines(x = c(y,y), y = c(x,y))
  #     grid.lines(x = c(x,y), y = c(x,x))
  #     grid.lines(x = c(x,y), y = c(y,y))
  #   }
  # })
  
}


