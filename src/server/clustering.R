require('gridExtra')
require('factoextra')
source('src/utilities.R')

cls_kmeans <- function(data, range) {
    range <- c(range[1]:range[2])
    clusterings <- vector("list", length(range))
    params = list(x = data, nstart = 25, iter.max = 100)
    for (i in 1:length(range)) {
        params$centers = range[i]
        clustering <- do.call(kmeans, params)
        clusterings[i] <- list(clustering)
    }
    return(clusterings)
}

cls_hclust <- function(data, range) {
    range <- c(range[1]:range[2])
    clusterings <- vector("list", length(range))
    for (i in 1:length(range)) {
        params = list(data, k = range[i])
        clustering <- do.call(hcut, params)
        clusterings[i] <- list(clustering)
    }
    return(clusterings)
}

plt_any <- function(data, clusterings) {
    plots <- vector("list", length(clusterings))
    for (i in 1:length(clusterings)) {
        k <- get_k(clusterings[[i]])
        plot <- fviz_cluster(clusterings[[i]], geom = "point", data = data) +
                ggtitle(paste0("k = ", k))
        plots[i] <- list(plot)
    }
    plots$ncol = 3
    return(plots)
}

run_kmeans <- function(data, range) {
    clusterings <- cls_kmeans(data, range)
    plots <- plt_any(data, clusterings)
    return(plots)
}

run_hclust <- function(data, range) {
    clusterings <- cls_hclust(data, range)
    plots <- plt_any(data, clusterings)
    return(plots)
}

run_clustering <- function(data, method, range) {
    if (method == 'kmeans') {
        return(run_kmeans(data, range))
    } else if (method == 'hclust') {
        return(run_hclust(data, range))
    }
}
