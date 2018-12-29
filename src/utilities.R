get_k <- function(clustering) {
    if (class(clustering)[1] == "kmeans") {
        return(nrow(clustering$centers))
    } else if (class(clustering)[1] == "pam") {
        return(nrow(clustering$medoids))
    } else if (class(clustering)[1] == "hclust") {
        return(clustering$nbclust)
    }
}
