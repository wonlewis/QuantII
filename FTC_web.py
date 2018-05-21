import re
import requests
import csv

main_url = 'https://www.ftc.gov/enforcement/cases-proceedings?items_per_page=100'
output_filename = 'all_FTC_results.csv'


# First get overview information about how many pages there are in total.
r = requests.get(main_url)
assert r.status_code==200,'Error retrieving webpage with error code:' + str(r.status_code)
last_page_result = re.search(r'page=([0-9]*)">last .<\/a>',r.text)
if last_page_result:
    page_count = int(last_page_result.groups()[0]) + 1
else:
    raise ValueError('Cannot detect what the last page is. Perhaps the FTC website format has changed.')
    
    
# Cycles through all the N pages and then extract the information from each page
all_results = []
for page_id in range(page_count):
    page_url = main_url + '&page=' + str(page_id)
    r = requests.get(page_url)
    assert r.status_code==200,'Error code ' +str(r.status_code) +' when retrieving webpage:' + page_url
    # The following is to pattern match and find each single case.
    #regex_search_string = re.compile('<tr class=.*?>\s*<td >\s*<span class="responsive-header">Updated: <\/span>\s*<time.*?>\s*<span.*?>(?P<date>.*?)<\/span>\s*<\/time>\s*<\/td>\s*<td class="views-field views-field-title" >\s*<span class="responsive-header">Title: <\/span>\s*<a href="(?P<urllink>.*?)">(?P<urltext>.*?)<\/a>\s*(?P<casetype>.*?)\s*<\/td>\s*<td >\s*<span class="responsive-header">FTC Matter \/ File No.: <\/span>\s*(?P<casenumber>.*?)\s*<\/td>\s*<\/tr>',re.DOTALL)
    regex_search_string = re.compile(r'<tr class=.*?>\s*<td >(?P<date>.*?)<\/td>\s*<td class="views-field views-field-title" >(?P<link>.*?)<\/td>\s*<td >(?P<casenumber>.*?)<\/td>',re.DOTALL)
    # Parse each page to get a list of all the cases and its details.
    page_results = [m.groupdict() for m in regex_search_string.finditer(r.text)]
    if page_results:
        all_results += page_results
        print('Parsed page {} of {} with {} accumulated results.'.format(page_id+1,page_count,len(all_results)))
    else:
        raise ValueError('Unable to use the regex search string to find cases. Probably the website syntax has changed.')

# Helper functions to help clean up text
strip_FTC_javscriptheaders = lambda raw_text: re.sub('<span class="responsive-header">.*?<\/span>','',raw_text)
strip_HTML_tags = lambda raw_text: re.sub('<.*?>','',raw_text)
strip_whitespaces = lambda raw_text: re.sub('\s*','',raw_text)
        
# Saves the results to file.
with open(output_filename, 'w') as csvfile:
    writer = csv.writer(csvfile, delimiter='\t', lineterminator='\n')
    writer.writerow(["Date","Case type","Case numbers",'Description','URL'])
    for result in all_results:
        #cleaned_case_numbers = re.sub("\s","",re.sub(r"<.*?>","",re.sub(r"<\/p>",",",result['casenumber']))).strip(',')
        #cleaned_case_type = re.sub("[\(\)]","",result['casetype'])
        link_result = re.search(r'<a href="(?P<urllink>.*?)">(?P<urltext>.*?)<\/a>\s*(?P<casetype>.*)',result['link'],re.DOTALL).groups()
        
        cleaned_date = strip_HTML_tags(strip_FTC_javscriptheaders(result['date'])).strip()
        cleaned_case_numbers = strip_whitespaces(strip_HTML_tags(re.sub(r"<\/p>",",",strip_FTC_javscriptheaders(result['casenumber'])))).strip(',')
        cleaned_case_type = re.sub("[\(\)]","",strip_whitespaces(strip_HTML_tags(strip_FTC_javscriptheaders(link_result[2]))))
        writer.writerow([cleaned_date,cleaned_case_type,cleaned_case_numbers,link_result[1],link_result[0]])


print('Output of {} results saved to {}.'.format(len(all_results),output_filename))