library(readr)
library(here)
library(umap)

df = read_tsv(here("probedata/GDC-BRCA-METH450.tsv.bgz"))

df_rotated <- df[-1] |> t()
umap_result <- umap::umap(d = df_rotated, method = "naive")
df_umap <- as.data.frame(umap_result$layout)
df_umap <- cbind(df_umap, rownames(df_rotated))

colnames(df_umap) <- c("Dim1", "Dim2", "Sample")
rownames(df_umap) <- NULL

# Truncate
df_umap[["Sample"]] <- substr(df_umap[["Sample"]], 1, 15)

# Write Output
write_csv(df_umap, here("BRCA_meth_umap.csv"))
