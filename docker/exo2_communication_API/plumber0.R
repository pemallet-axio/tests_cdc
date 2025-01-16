# plumber0.R

library(readr)

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
	cat("Message reçu:", msg, "\n")

	list(msg = paste0("The message is: '", msg, "'"))
}

#* Echo back the input
#* @param msg The message to echo
#* @get /create
function(){
	data <- data.frame(
  	"categ" = c("categ1", "categ2", "categ3"),
  	"number" = c(100, 200, 250),
  	"prop" = c(.1, .5, .33)
	)
	write.csv(data, "/home/results/dummy_data.csv")
}

#* Plot a histogram
#* @serializer png
#* @get /plot
function() {
  rand <- rnorm(100)
  hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
  as.numeric(a) + as.numeric(b)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum2
function(a="", b="") {
  as.numeric(a) + as.numeric(b)
}

########################
## Tests d'import de csv

#* Read a csv file and print it as a df
#* @param dataset:file
#* @post /test_load
function(req){
	df <- read.csv(file = req$postBody, dec = ".", sep = ",",stringsAsFactors = FALSE )
}

#* Read a csv file and print it as a df
#* @param dataset:file
#* @post /load
function(req){
	print(req)
	print("Attributs")
	print(names(req))

	# Afficher tous les attributs détaillés
	cat("Contenu de req$body :\n")
	print(names(req$body))
	
	cat("Contenu de .bodyData :\n")
	print(req$.bodyData)

	cat("Test d'acces")
	dataset <- req$body$dataset
	cat("Ah bah ... Cool !")

	print("Data")
	print(dataset)
	print(typeof(dataset$filename))
	df <- read.csv(file = dataset$filename, dec = ".", sep = ",",stringsAsFactors = FALSE )

	tryCatch({
		cat("test_1")
		cat(dataset$filename)
    df <- read.csv(file = dataset$filename, dec = ".", sep = ",",stringsAsFactors = FALSE )
	cat("fin_test_1")
	cat(df)
	})
	tryCatch({
		print("test_2")
    df <- read.csv(file = dataset$datapath, dec = ".", sep = ",",stringsAsFactors = FALSE )
	})
	df <- read.csv(file=dataset, dec=".", sep= ",", quote =False )

	print(df)

	  # Tenter de récupérer le fichier de différentes manières
	if (!is.null(req$files) && length(req$files) > 0) {
		cat("files pas vide")
		dataset <- req$files[[1]]
	} else if (!is.null(req$body$.bodyData)) {
		cat("sinon, req body pas vide")
		dataset <- req$body$.bodyData
	} else {
		stop("Aucun fichier trouvé dans la requête")
	}
	
	# Vérification et lecture du fichier
	if (is.null(dataset$datapath)) {
		stop("Impossible de trouver le chemin du fichier")
	}

	data <- req$files$dataset
	print("Data")
	print(data)
	print(typeof(dataset))
	df <- read.csv(file=dataset, dec=".", sep= ",", quote =False )

	print("Dataframe")
	print(df)
}
