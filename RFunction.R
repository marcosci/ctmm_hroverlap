library(ctmm)

rFunction = function(data) {
  
  ov <- overlap(data[[2]]) 
  
  ov <- overlap(data[[2]], method = "Encounter") 
  res <- apply(ov$CI, 1:2, function(x) {
    x <- format(round(x, 2), nsmall = 2)
    paste0(x[2], " (", x[1], " - ", x[3], ")")
  })
  capture.output(res, file = appArtifactPath("overlap_summary_matrix.txt"))
  
  
  # Second artefact
  res <- bind_cols(
    ov$CI[, , 1] |> as.data.frame() |> rownames_to_column(var = "from") |> 
      pivot_longer(-from, names_to = "to", values_to = "low"),
    ov$CI[, , 2] |> as.data.frame() |> rownames_to_column(var = "from") |> 
      pivot_longer(-from, names_to = "to", values_to = "est") |> select(est),
    ov$CI[, , 3] |> as.data.frame() |> rownames_to_column(var = "from") |> 
      pivot_longer(-from, names_to = "to", values_to = "high") |> select(high)
  )
  write.csv(res, file = appArtifactPath("overlap_summary_long.txt"))
  
  
  
  return(data)
  
}