\name{clusKNN}

\alias{clusKNN}

\title{clusKNN}

\description{A wrapper function for Seurat's FindNeighbors and FindClusters.}

\usage{
  clusKNN(
    indata,
    reducedDim = 'UMAP',
    dimColnames = c('UMAP1','UMAP2'),
    clusterAssignName = 'Cluster',
    distance.matrix = FALSE,
    k.param = 20,
    compute.SNN = TRUE,
    prune.SNN = 1/15,
    nn.method = 'rann',
    annoy.metric = 'euclidean',
    nn.eps = 0,
    verbose = TRUE,
    force.recalc = FALSE,
    modularity.fxn = 1,
    initial.membership = NULL,
    weights = NULL,
    node.sizes = NULL,
    resolution = 0.8,
    method = 'matrix',
    algorithm = 1,
    n.start = 10,
    n.iter = 10,
    random.seed = 0,
    group.singletons = TRUE,
    temp.file.location = NULL,
    edge.file.name = NULL,
    overwrite = FALSE)
}

\arguments{
  \item{indata}{A data-frame or matrix, or SingleCellExperiment object. If a
    SingleCellExperiment object, the cell-to-cluster assignments will be
    added as a new column, specified by 'clusterAssignName', to the input
    object's metadata; if a data-frame or matrix, only the cluster assignment
    vector is returned. REQUIRED.}
  \item{reducedDim}{A reduced dimensional component stored within 'indata',
    e.g., PCA or UMAP. DEFAULT = 'UMAP'. OPTIONAL.}
  \item{dimColnames}{The column names of the dimensions to use. DEFAULT
    = c('UMAP1','UMAP2'). OPTIONAL.}
  \item{clusterAssignName}{The new column name in the metadata that will
    contain the determined cell-to-cluster assignments. DEFAULT = 'Cluster'.
    OPTIONAL.}
  \item{distance.matrix}{Refer to ?Seurat::FindNeighbors. DEFAULT = FALSE.
    OPTIONAL.}
  \item{k.param}{Refer to ?Seurat::FindNeighbors. DEFAULT = 20. OPTIONAL.}
  \item{compute.SNN}{Refer to ?Seurat::FindNeighbors. DEFAULT = TRUE.
    OPTIONAL.}
  \item{prune.SNN}{Refer to ?Seurat::FindNeighbors. DEFAULT = 1/15. OPTIONAL.}
  \item{nn.method}{Refer to ?Seurat::FindNeighbors. DEFAULT = 'rann'.
    OPTIONAL.}
  \item{annoy.metric}{Refer to ?Seurat::FindNeighbors. DEFAULT = 'euclidean'.
    OPTIONAL.}
  \item{nn.eps}{Refer to ?Seurat::FindNeighbors. DEFAULT = 0. OPTIONAL.}
  \item{verbose}{Refer to ?Seurat::FindNeighbors. DEFAULT = TRUE. OPTIONAL.}
  \item{force.recalc}{Refer to ?Seurat::FindNeighbors. DEFAULT = FALSE.
    OPTIONAL.}
  \item{modularity.fxn}{Refer to ?Seurat::FindClusters. DEFAULT = 1. OPTIONAL.}
  \item{initial.membership}{Refer to ?Seurat::FindClusters. DEFAULT = NULL.
    OPTIONAL.}
  \item{weights}{Refer to ?Seurat::FindClusters. DEFAULT = NULL. OPTIONAL.}
  \item{node.sizes}{Refer to ?Seurat::FindClusters. DEFAULT = NULL. OPTIONAL.}
  \item{resolution}{Refer to ?Seurat::FindClusters. DEFAULT = 0.8. OPTIONAL.}
  \item{method}{Refer to ?Seurat::FindClusters. DEFAULT = 'matrix'. OPTIONAL.}
  \item{algorithm}{Refer to ?Seurat::FindClusters. DEFAULT = 1. OPTIONAL.}
  \item{n.start}{Refer to ?Seurat::FindClusters. DEFAULT = 10. OPTIONAL.}
  \item{n.iter}{Refer to ?Seurat::FindClusters. DEFAULT = 10. OPTIONAL.}
  \item{random.seed}{Refer to ?Seurat::FindClusters. DEFAULT = 0. OPTIONAL.}
  \item{group.singletons}{Refer to ?Seurat::FindClusters. DEFAULT = TRUE.
    OPTIONAL.}
  \item{temp.file.location}{Refer to ?Seurat::FindClusters. DEFAULT = NULL.
    OPTIONAL.}
  \item{edge.file.name}{Refer to ?Seurat::FindClusters. DEFAULT = NULL. OPTIONAL.}
  \item{overwrite}{When the input object is a SingleCellExperiment, enabling
    this will result in the overwriting, with the new cluster assignments, of
    any column in your metadata that has the same name as 'clusterAssignName'.
    DEFAULT = FALSE. OPTIONAL.}
}

\value{
A \code{\link{SingleCellExperiment}} or \code{\link{numeric}}object.
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

  clusKNN(mat)
}
