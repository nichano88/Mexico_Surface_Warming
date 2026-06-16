How to Use

1. Use Extract Variables.R to extract all the vars from your RAW DATA   
2. Regrid and annually average data using changingDataRes.R
3. Use FinalPlotting.R to acheive plotting and analysis results seen in thesis using this new data
4. Save your data and plots\!

Downloading the RAW DATA

1. Download txt file with all the urls inside of desired dataset  
2. Make a .netrc file in terminal using “nano \~/.netrc”  
3. Add the following into the file:  
   machine urs.earthdata.nasa.gov  
       login YOUR\_USERNAME  
       password YOUR\_PASSWORD  
4. Control X to exit \+ press yes \+ press enter  
5. Now type “chmod 600 \~/.netrc” to give permissions  
6. Finally run:

	wget \--load-cookies \~/.urs\_cookies \--save-cookies \~/.urs\_cookies \\  
     \--keep-session-cookies \--auth-no-challenge=on \\  
     \-i new\_dataset\_urls.txt