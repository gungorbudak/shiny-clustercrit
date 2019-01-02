require('tidyr')
require('clusterSim')

summary_process <- function(sum) {
  x <- separate(na.omit(as.data.frame(sum)[, -1]), Freq, into=c("Metric", "Value"), sep=":")
  colnames(x)[1] <- "Variable"
  return(reshape(x, idvar = "Variable", timevar = "Metric", direction = "wide"))
}

data_show <- function(data, display_option) {
  switch(display_option,
    "all" = return(data),
    "head" = return(head(data)),
    "tail" =  return(tail(data)),
    "summary" = return(summary_process(summary(data)))
  )
}

best_variables <- function(pca_obj, cutoff = 0.9) {
    vars = pca_obj$sdev^2 / sum(pca_obj$sdev^2)
    total_var <- 0
    for (i in 1:length(vars)) {
        total_var <- total_var + vars[i]
        if (total_var > cutoff) {
            break
        }
    }
    return(pca_obj$x[, 1:i, drop = FALSE])
}

data_preprocess <- function(data, fill_missing, scale, centralize, normalize, reduce_dimension) {
  processed_data <- data
  if (fill_missing != "") {
    for (i in 1:ncol(data)){
      data[is.na(data[, i]), i] <- do.call(fill_missing, list(data[, i], na.rm = TRUE))
    }
    processed_data <- data
  }
  if (scale || centralize) {
    processed_data <- scale(data, scale = scale, center = centralize)
  }
  if (normalize != "") {
    processed_data <- data.Normalization(data, type = normalize, normalization = "column")
  }
  if (reduce_dimension) {
    processed_data <- best_variables(prcomp(data))
  }
  return(processed_data)
}
