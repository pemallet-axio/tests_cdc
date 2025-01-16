library(plumber)

cat("Démarrage de l'API Plumber...\n")

### 'plumber.R' is the location of the file shown above
#pr("/home/analysis/plumber0.R") %>%
#  pr_run(port=80)

pr <- plumber::plumb("/home/analysis/plumber0.R")

# Log des routes
cat("Routes disponibles:\n")
print(pr$routes)

pr$run(host='0.0.0.0', port=80)