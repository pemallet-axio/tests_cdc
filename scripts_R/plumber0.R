# plumber0.R

library(readr)

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg="") {
  list(msg = paste0("The message is : '", msg, "'"))
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


#* Read a csv file and print it as a df
#* @post /load
function(req, res) {
	if(missing(req)){
		stop("Pas de fichier uploadé !")
	}
    mp <- mime::parse_multipart(req)
	print(mp)
    df <- readr::read_csv(mp$file$datapath)
	print("Fichier reçu !")
	print(df)
	#write.csv(df, "dummy_data_out2.csv")
	#print("Fichier écrit !")
}




#* Log some information about the incoming request
#* @filter logger
function(req){
  print('LOGGER')
  print( req)
  cat(as.character(Sys.time()), "-",
      req$REQUEST_METHOD, req$PATH_INFO, "-",
      req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n")
  plumber::forward()
}


#* @filter bodyInspection
function(req, res){
  print("REQUETE")
  print(req)
  print( 'POST BODY')
  print(req$postBody)
  print("filename = ")
  print(req$postBody[1])
  print(req$postBody[2])
  print("TYPE")
  print(typeof(12))
  print(typeof(req))
  print(typeof(req$postBody))
  print("BODY")
  print(req$body)
  print("ARGS BODY")
  print(req$argsBody)
  print("ARGS PATH")
  print(req$argsPath)
  print("ARGS QUERY")
  print(req$argsQuery)
  print("COOKIES")
  print(req$cookies)
  print("PATH INFO")
  print(req$PATH_INFO)
  print("BODY RAW")
  print(req$bodyRaw)
  if (is.null(req$postBody)){
    res$status <- 404 
    return(list(error="Body not found"))
  } else {
    plumber::forward()
  }
}

#* @post /summarize
#* @serializer print
function(req){
  print("test")
  multipart <- mime::parse_multipart(req)
  data<-csv(multipart$upload$datapath, header=T)
  summary(data)
}



############### Reponse

#* Return a txt
#* @get /sendtxt
function(req, res){
  include_file("test.txt", res)
}

#* Return a html
#* @get /sendhtml
function(req, res){
  include_file("test.html", res)
}

#* Return a csv
#* @get /sendcsv
function(req, res){
  include_file("dummy_data.csv", res)
}

#* Return a xlsx
#* @get /sendxlsx
function(req, res){
  include_file("test.xlsx", res, content_type = getContentType(tools::file_ext("test.xlsx")))
}