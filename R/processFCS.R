processFCS <- function(
  files,
  assayname = 'scaled',
  metadata = NULL,
  filter = TRUE,
  bgNoiseThreshold = 1,
  euclideanNormThreshold = 1,
  transformation = TRUE,
  transFun = function (x) asinh(x),
  asinhFactor = 5,
  downsample = 100000,
  downsampleVar = 0.1,
  colsDiscard = c('Time','Event_length','Center','Offset','Width',
    'Residual','tSNE1','tSNE2','BCKG'),
  colsRetain = NULL,
  newColnames = NULL)
{
  # if metadata specified, enforce rule that rownames(metadata) is the
  # same as filelist
  if (!is.null(metadata)) {
    if(!identical(files, rownames(metadata))) {
      stop("'filelist' is not identical to 'rownames(metadata)'")
    }
  }

  # read in the data to a list
  samples <- list()
  samples <- lapply(files,
    function(x) exprs(read.FCS(x, transformation = FALSE)))
  names(samples) <- files

  # filter markers out
  if (!is.null(colsDiscard)) {
    samples <- lapply(
      samples,
      function(x) if (length(which(colnames(x) %in% colsDiscard)) > 0) {
        x[,-which(colnames(x) %in% colsDiscard)]} else {return(x)})
  }

  # filter markers in
  if (!is.null(colsRetain)) {
    samples <- lapply(
      samples,
      function(x) if (length(which(colnames(x) %in% colsRetain)) > 0) {
        x[,which(colnames(x) %in% colsRetain)]} else {return(x)})
  }

  # rename markers
  if(!is.null(newColnames)) {
    for(i in seq_len(length(samples))) {
      colnames(samples[[i]]) <- newColnames
    }
  }

  # filter
  if (filter == TRUE) {
    message('--filtering background / noise')

    # Euclidean norm
    samples <- lapply(
      samples,
      function(x)
        x[apply(x, 1, FUN = function(x) sqrt(sum(x^2))) > euclideanNormThreshold,])

    # noise correction
    for(i in seq_len(length(samples))) {
      x <- samples[[i]]
      x[x < bgNoiseThreshold] <- 0
      samples[[i]] <- x
    }
  }

  # transform
  if (transformation == TRUE) {
    message('--transforming data')
    samples <- lapply(
      samples,
      function(x) transFun(x / asinhFactor))
  }

  # load function for downsampling based on variance
  if(!is.null(downsampleVar)) {
    if (downsampleVar > 0) {
      samples <- lapply(
        samples,
        function(x) downsampleByVar(x, varianceFactor = downsampleVar))
    }
  }

  # is there metadata?
  names <- colnames(metadata)
  metanew <- list()
  if (!is.null(metadata)) {
    for (i in seq_len(length(samples))) {
      tmp <- data.frame(row.names = seq_len(nrow(samples[[i]])))
      for (j in seq_len(ncol(metadata))) {
        tmp <- cbind(tmp, rep(metadata[i,j], nrow(samples[[i]])))
      }
      metanew[[i]] <- tmp
    }

    metadata <- do.call(rbind, metanew)
    colnames(metadata) <- names
    rownames(metadata) <- paste0('cell', seq_len(nrow(metadata)))
  }

  # combine all samples
  samples <- do.call(rbind, samples)
  rownames(samples) <- paste0('cell', seq_len(nrow(samples)))

  # downsample
  if (!is.null(downsample)) {
    if (downsample > nrow(samples)) {
      warning('Cannot downsample to ', downsample, ' number of variables as',
        ' there are ', nrow(samples), ' variables currently in the merged ',
        'dataset.')
      message('--Skipping downsampling')
    } else {
      message('--Downsampling to ', downsample, ' variables.')
      idx <- sample(seq_along(nrow(samples)), downsample)
      samples <- samples[idx,]
      metadata <- metadata[idx,]

      rownames(metadata) <- paste0('cell', seq_len(nrow(metadata)))
      rownames(samples) <- paste0('cell', seq_len(nrow(samples)))
    }
  }

  # these should be equal
  if (!is.null(metadata)) {
    if (nrow(metadata) != nrow(samples)) {
      stop(paste0('Metadata does not match expression data',
        ' - please check your input.'))
    }
  }

  # return a SingleCellExperiment object
  ret <- list(t(samples))
  names(ret)[1] <- assayname
  ret <- SingleCellExperiment(
    assays = ret)
  metadata(ret) <- metadata
  return(ret)
}
