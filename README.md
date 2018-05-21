# QuantII
Project on effect of lobbying on FTC initiation of investigation

I scrape data from 3 sources. 

1. FTC enforcement rulings: https://www.ftc.gov/enforcement/cases-proceedings?items_per_page=100. Each individual case is listed as a single entry on the FTC website. Data is scraped using Python, and the python code is found in FTC_web.py. All entries from the webite are scraped. The code generates a csv file called all_FTC_results.csv 

2. Lobbying data: https://www.senate.gov/legislative/Public_Disclosure/database_download.htm. The lobbying data are on a quarterly basis in zip files. I use Bash to download all the zip files from the congress website using download.sh. All quarterly reports from the congress websites are scraped. I then use Jupiter Notebook to run process-data.ipynb. This python code parses all the xml files into a table format readable by R.

3. Compustat North America: https://libguides.mit.edu/c.php?g=176014&p=1160948. After downloading the data, I do the following to merge the data:
3a. I use the company names in the three databases as the ID to match the rows. I use company_nammes_clean.R to simplify the company names by making all characters uppercase, remove punctuations, remove spaces.
3b. I then use strmatch.R to match the company names. I have a few choices, and eventually settled on Jaro-Winkler for the most suitable match. Levenshtein, cosine are useful for spotting mispellings, but it is unlikely that misspelling will happen for datasets matained by the US Congress, Compustat, or the FTC.
