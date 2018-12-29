require('ggplot2')
require('clusterCrit')
source('src/utilities.R')

run_validation <- function(data, clusterings, criteria, method) {
    data <- as.matrix(data)
    pdata.x <- c()
    pdata.y <- vector("list", length(criteria))
    names(pdata.y) <- criteria
    for (i in 1:length(clusterings)) {
        intIdx <- intCriteria(data, clusterings[[i]]$cluster, criteria)
        k <- get_k(clusterings[[i]])
        pdata.x <- c(pdata.x, k)
        for (c in criteria) {
            pdata.y[[c]] <- c(pdata.y[[c]], intIdx[[tolower(c)]])
        }
    }
    plots <- vector("list", length(criteria))
    for (i in 1:length(criteria)) {
        pdata <- data.frame(k=pdata.x, value=pdata.y[[criteria[i]]])
        best_k <- bestCriterion(pdata.y[[criteria[i]]], criteria[i]) + 1
        plot <- ggplot(data=pdata, aes(x=k, y=value, group=1)) +
            geom_line(color="blue") + geom_point(color="blue") +
            ggtitle(paste0(method, " - ", criteria[i])) +
            geom_point(data=pdata[pdata$k == best_k, ], pch = 21, fill = NA, size = 5,
                       color = "green3", stroke = 2) +
            scale_x_discrete(limits=pdata$k)
        plots[[i]] <- plot
    }
    plots$ncol <- 3
    return(plots)
}
