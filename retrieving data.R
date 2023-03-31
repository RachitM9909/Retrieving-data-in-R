#Retrieving data from i)databases,
ii)api
iii)csv,
iv)xlsx,
v)url,
vi)text


I)
>library("readxl")
> df=read_xlsx("C:/Users/mistr/OneDrive/Documents/houseprice.xlsx")
> df

II)
> fromcsv = read.csv("C:/Users/mistr/OneDrive/Documents/test_X.csv")
> fromcsv

III)
> fromtext <-read.table("C:/Users/mistr/OneDrive/Documents/Stats.txt", header = TRUE,sep="\t",dec=".") 
> fromtext

IV)
> url <- "https://data.bloomington.in.gov/dataset/f560924e-e346-4fbb-9c9a-3f3cfe49b885/resource/8c782cf0-cc8a-402a-9229-4d76e0282fc6/download/data-exported-from-google-analytics-for-2018.csv"
> setwd(file.path("C:/Users/mistr/Downloads"))
> local<-file.path("data","demodt.data")
> download.file(url,local)
> my.data<-read.table(local,sep=",")
>my.data

V)
> library(RMySQL)
> mysqlconnection = dbConnect(MySQL(),user="root",password="mysql",dbname='student',host='localhost')
> result = dbSendQuery(mysqlconnection,"select * from student;")
> data.frame=fetch(result,n=5)
> print(data.frame)

VI)
> pacman::p_load(httr,jsonlite,dplyr)
> my_url<-paste0("https://api.publicapis.org/entries")
> my_raw_result<-httr::GET(my_url)
> str(str_raw_result)
Error in str(str_raw_result) : object 'str_raw_result' not found
> str(my_raw_result)
List of 10
$ url        : chr "https://api.publicapis.org/entries"
$ status_code: int 200
$ headers    :List of 9
..$ access-control-allow-origin       : chr "*"
..$ content-type                      : chr "application/json"
..$ date                              : chr "Thu, 09 Feb 2023 14:36:22 GMT"
..$ server                            : chr "Caddy"
..$ x-rate-limit-duration             : chr "1"
..$ x-rate-limit-limit                : chr "10.00"
..$ x-rate-limit-request-forwarded-for: chr "152.58.19.7"
..$ x-rate-limit-request-remote-addr  : chr "172.17.0.1:40446"
..$ transfer-encoding                 : chr "chunked"
..- attr(*, "class")= chr [1:2] "insensitive" "list"
$ all_headers:List of 1
..$ :List of 3
.. ..$ status : int 200
.. ..$ version: chr "HTTP/1.1"
.. ..$ headers:List of 9
.. .. ..$ access-control-allow-origin       : chr "*"
.. .. ..$ content-type                      : chr "application/json"
.. .. ..$ date                              : chr "Thu, 09 Feb 2023 14:36:22 GMT"
.. .. ..$ server                            : chr "Caddy"
.. .. ..$ x-rate-limit-duration             : chr "1"
.. .. ..$ x-rate-limit-limit                : chr "10.00"
.. .. ..$ x-rate-limit-request-forwarded-for: chr "152.58.19.7"
.. .. ..$ x-rate-limit-request-remote-addr  : chr "172.17.0.1:40446"
.. .. ..$ transfer-encoding                 : chr "chunked"
.. .. ..- attr(*, "class")= chr [1:2] "insensitive" "list"
$ cookies    :'data.frame':	0 obs. of  7 variables:
  ..$ domain    : logi(0) 
..$ flag      : logi(0) 
..$ path      : logi(0) 
..$ secure    : logi(0) 
..$ expiration: 'POSIXct' num(0) 
..$ name      : logi(0) 
..$ value     : logi(0) 
$ content    : raw [1:280651] 7b 22 63 6f ...
$ date       : POSIXct[1:1], format:  ...
$ times      : Named num [1:6] 0 0.0362 0.3847 0.9504 1.2364 ...
..- attr(*, "names")= chr [1:6] "redirect" "namelookup" "connect" "pretransfer" ...
$ request    :List of 7
..$ method    : chr "GET"
..$ url       : chr "https://api.publicapis.org/entries"
..$ headers   : Named chr "application/json, text/xml, application/xml, */*"
.. ..- attr(*, "names")= chr "Accept"
..$ fields    : NULL
..$ options   :List of 2
.. ..$ useragent: chr "libcurl/7.84.0 r-curl/5.0.0 httr/1.4.4"
.. ..$ httpget  : logi TRUE
..$ auth_token: NULL
..$ output    : list()
.. ..- attr(*, "class")= chr [1:2] "write_memory" "write_function"
..- attr(*, "class")= chr "request"
$ handle     :Class 'curl_handle' <externalptr> 
  - attr(*, "class")= chr "response"
> str(my_raw_result$content)
raw [1:280651] 7b 22 63 6f ...
> my_content<-httr::content(my_raw_result,as="text")
No encoding supplied: defaulting to UTF-8.
> str(my_content)
chr "{\"count\":1425,\"entries\":[{\"API\":\"AdoptAPet\",\"Description\":\"Resource to help get pets adopted\",\"Aut"| __truncated__
> my_content_from_json<-jsonlite::fromJSON(my_content)
> dplyr::glimpse(my_content_from_json)
List of 2
$ count  : int 1425
$ entries:'data.frame':	1425 obs. of  7 variables:
  ..$ API        : chr [1:1425] "AdoptAPet" "Axolotl" "Cat Facts" "Cataas" ...
..$ Description: chr [1:1425] "Resource to help get pets adopted" "Collection of axolotl pictures and facts" "Daily cat facts" "Cat as a service (cats pictures and gifs)" ...
..$ Auth       : chr [1:1425] "apiKey" "" "" "" ...
..$ HTTPS      : logi [1:1425] TRUE TRUE TRUE TRUE TRUE TRUE ...
..$ Cors       : chr [1:1425] "yes" "no" "no" "no" ...
..$ Link       : chr [1:1425] "https://www.adoptapet.com/public/apis/pet_list.html" "https://theaxolotlapi.netlify.app/" "https://alexwohlbruck.github.io/cat-facts/" "https://cataas.com/" ...
..$ Category   : chr [1:1425] "Animals" "Animals" "Animals" "Animals" ...
> api_df<-my_content_from_json$count
> dplyr::glimpse(api_df)
