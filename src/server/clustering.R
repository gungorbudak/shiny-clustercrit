require('gridExtra')
require('factoextra')
require('cluster')
source('src/utilities.R')

cls_kmeans <- function(data, range, params) {
    range <- c(range[1]:range[2])
    clusterings <- vector("list", length(range))
    params$x <- data
    for (i in 1:length(range)) {
        params$centers <- range[i]
        clustering <- do.call(kmeans, params)
        clusterings[i] <- list(clustering)
    }
    return(clusterings)
}

cls_pam <- function(data, range, params) {
    range <- c(range[1]:range[2])
    clusterings <- vector("list", length(range))
    params$x <- data
    for (i in 1:length(range)) {
        params$k <- range[i]
        clustering <- do.call(pam, params)
        clusterings[i] <- list(clustering)
    }
    return(clusterings)
}

cls_hcut <- function(data, range, params) {
    range <- c(range[1]:range[2])
    clusterings <- vector("list", length(range))
    params$x <- data
    for (i in 1:length(range)) {
        params$k <- range[i]
        clustering <- do.call(hcut, params)
        clusterings[i] <- list(clustering)
    }
    return(clusterings)
}

plt_any <- function(data, clusterings, method) {
    plots <- vector("list", length(clusterings))
    for (i in 1:length(clusterings)) {
        k <- get_k(clusterings[[i]])
        plot <- fviz_cluster(clusterings[[i]], geom = "point", data = data) +
                ggtitle(paste0(method, " / k = ", k))
        plots[i] <- list(plot)
    }
    plots$ncol = 3
    return(plots)
}
