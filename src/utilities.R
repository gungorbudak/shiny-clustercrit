get_k <- function(clustering) {
    if ("nbclust" %in% names(clustering)) {
        return(clustering$nbclust)
    } else {
        return(nrow(clustering$centers))
    }
}
