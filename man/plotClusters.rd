\name{plotClusters}

\alias{plotClusters}

\title{plotClusters}

\description{Highlight cell-to-cluster assignments across a 2-dimensional reduction / embedding.}

\usage{
  plotClusters(
    indata,
    clusterVector = NULL,
    reducedDim = 'UMAP',
    dimColnames = c('UMAP1','UMAP2'),
    clusterColname = 'Cluster',
    pointSize = 0.5,
    legendPosition = 'none',
    legendLabSize = 12,
    legendIconSize = 5.0,
    xlim = NULL,
    ylim = NULL,
    label = TRUE,
    labSize = 5.0,
    labhjust = 1.5,
    labvjust = 0,
    drawConnectors = TRUE,
    widthConnectors = 0.5,
    colConnectors = 'black',
    xlab = dimColnames[1],
    xlabAngle = 0,
    xlabhjust = 0.5,
    xlabvjust = 0.5,
    ylab = dimColnames[2],
    ylabAngle = 0,
    ylabhjust = 0.5,
    ylabvjust = 0.5,
    axisLabSize = 16,
    title = 'k-nearest neighbour (k-NN) clusters',
    subtitle = '',
    caption = ifelse(is(indata, 'SingleCellExperiment'),
      paste0('Total cells, ',
        nrow(as.data.frame(reducedDim(indata, reducedDim)))),
      paste0('Total cells, ', length(clusterVector))),
    titleLabSize = 16,
    subtitleLabSize = 12,
    captionLabSize = 12,
    hline = NULL,
    hlineType = 'longdash',
    hlineCol = 'black',
    hlineWidth = 0.4,
    vline = NULL,
    vlineType = 'longdash',
    vlineCol = 'black',
    vlineWidth = 0.4,
    gridlines.major = TRUE,
    gridlines.minor = TRUE,
    borderWidth = 0.8,
    borderColour = 'black')
}

\arguments{
  \item{indata}{A data-frame or matrix, or SingleCellExperiment object. If a
    data-frame or matrix, columns named in 'dimColnames' will be extracted
    from the data and used to generate the plot. If a SingleCellExperiment
    object, a reduction named by 'reducedDim' will be taken from your object
    and used to generate the plot, again using columns whose names are
    specified in 'dimColnames'. REQUIRED.}
  \item{clusterVector}{If 'indata' is a non-SingleCellExperiment object,
    'clusterVector' must be non-NULL and relate to a cell-to-cluster
    assignment whose length matches 'nrow(indata)'. DEFAULT = NULL. OPTIONAL.}
  \item{reducedDim}{A reduced dimensional embedding stored within 'indata',
    e.g., PCA or UMAP. DEFAULT = 'UMAP'. OPTIONAL.}
  \item{dimColnames}{The column names of the dimensions to use. DEFAULT
    = c('UMAP1','UMAP2'). OPTIONAL.}
  \item{clusterColname}{The column name in the metadata of 'indata' that
    contains the cell-to-cluster assignment, assuming 'indata' is a
    SingleCellExperiment object. DEFAULT = 'Cluster'. OPTIONAL.}
  \item{pointSize}{Size of plotted points. DEFAULT = 0.5. OPTIONAL.}
  \item{legendPosition}{Position of legend ('top', 'bottom', 'left', 'right',
  'none'). DEFAULT = 'none'. OPTIONAL.}
  \item{legendLabSize}{Size of plot legend text. DEFAULT = 12. OPTIONAL.}
  \item{legendIconSize}{Size of plot legend icons / symbols. DEFAULT = 5.0.
  OPTIONAL.}
  \item{xlim}{Limits of the x-axis. DEFAULT = NULL. OPTIONAL.}
  \item{ylim}{Limits of the y-axis. DEFAULT = NULL. OPTIONAL.}
  \item{label}{Logical, indicating whether or not to label the clusters.
    DEFAULT = NULL. OPTIONAL.}
  \item{labSize}{Size of labels. DEFAULT = 5.0. OPTIONAL.}
  \item{labhjust}{Horizontal adjustment of label. DEFAULT = 1.5. OPTIONAL.}
  \item{labvjust}{Vertical adjustment of label. DEFAULT = 0. OPTIONAL.}
  \item{drawConnectors}{Logical, indicating whether or not to connect plot
    labels to their corresponding cluster islands by line connectors.
    DEFAULT = TRUE. OPTIONAL.}
  \item{widthConnectors}{Line width of connectors. DEFAULT = 0.5. OPTIONAL.}
  \item{colConnectors}{Line colour of connectors. DEFAULT = 'black'. OPTIONAL.}
  \item{xlab}{Label for x-axis. DEFAULT = dimColnames[1]. OPTIONAL.}
  \item{xlabAngle}{Rotation angle of x-axis labels. DEFAULT = 0. OPTIONAL.}
  \item{xlabhjust}{Horizontal adjustment of x-axis labels. DEFAULT = 0.5.
    OPTIONAL.}
  \item{xlabvjust}{Vertical adjustment of x-axis labels. DEFAULT = 0.5.
  OPTIONAL.}
  \item{ylab}{Label for y-axis. DEFAULT = dimColnames[2]. OPTIONAL.}
  \item{ylabAngle}{Rotation angle of y-axis labels. DEFAULT = 0. OPTIONAL.}
  \item{ylabhjust}{Horizontal adjustment of y-axis labels. DEFAULT = 0.5.
  OPTIONAL.}
  \item{ylabvjust}{Vertical adjustment of y-axis labels. DEFAULT = 0.5.
  OPTIONAL.}
  \item{axisLabSize}{Size of x- and y-axis labels. DEFAULT = 16. OPTIONAL.}
  \item{title}{Plot title. DEFAULT = 'k-nearest neighbour (k-NN) clusters'.
    OPTIONAL.}
  \item{subtitle}{Plot subtitle. DEFAULT = ''. OPTIONAL.}
  \item{caption}{Plot caption. DEFAULT =
    ifelse(is(indata, 'SingleCellExperiment'),
    paste0('Total cells, ',
    nrow(as.data.frame(reducedDim(indata, reducedDim)))),
    paste0('Total cells, ', length(clusterVector))). OPTIONAL.}
  \item{titleLabSize}{Size of plot title. DEFAULT = 16. OPTIONAL.}
  \item{subtitleLabSize}{Size of plot subtitle. DEFAULT = 12. OPTIONAL.}
  \item{captionLabSize}{Size of plot caption. DEFAULT = 12. OPTIONAL.}
  \item{hline}{Draw one or more horizontal lines passing through this/these
    values on y-axis. For single values, only a single numerical value is
    necessary. For multiple lines, pass these as a vector, e.g., c(60,90).
    DEFAULT = NULL. OPTIONAL.}
  \item{hlineType}{Line type for hline ('blank', 'solid', 'dashed', 'dotted',
    'dotdash', 'longdash', 'twodash'). DEFAULT = 'longdash'. OPTIONAL.}
  \item{hlineCol}{Colour of hline. DEFAULT = 'black'. OPTIONAL.}
  \item{hlineWidth}{Width of hline. DEFAULT = 0.4. OPTIONAL.}
  \item{vline}{Draw one or more vertical lines passing through this/these
    values on x-axis. For single values, only a single numerical value is
    necessary. For multiple lines, pass these as a vector, e.g., c(60,90).
    DEFAULT = NULL. OPTIONAL.}
  \item{vlineType}{Line type for vline ('blank', 'solid', 'dashed', 'dotted',
    'dotdash', 'longdash', 'twodash'). DEFAULT = 'longdash'. OPTIONAL.}
  \item{vlineCol}{Colour of vline. DEFAULT = 'black'. OPTIONAL.}
  \item{vlineWidth}{Width of vline. DEFAULT = 0.4. OPTIONAL.}
  \item{gridlines.major}{Logical, indicating whether or not to draw major
    gridlines. DEFAULT = TRUE. OPTIONAL.}
  \item{gridlines.minor}{Logical, indicating whether or not to draw minor
    gridlines. DEFAULT = TRUE. OPTIONAL.}
  \item{borderWidth}{Width of the border on the x and y axes. DEFAULT = 0.8.
    OPTIONAL.}
  \item{borderColour}{Colour of the border on the x and y axes. DEFAULT =
    'black'. OPTIONAL.}
}

\value{
A \code{\link{ggplot2}} object.
}

\author{
Kevin Blighe <kevin@clinicalbioinformatics.co.uk>
}

\examples{
  # create random data that follows a negative binomial
  mat <- jitter(matrix(
    MASS::rnegbin(rexp(1000, rate=.1), theta = 4.5),
    ncol = 20))
  colnames(mat) <- paste0('CD', 1:ncol(mat))
  rownames(mat) <- paste0('cell', 1:nrow(mat))

  u <- umap::umap(mat)
  clusvec <- clusKNN(u$layout)
  plotClusters(u$layout, clusvec)
}
