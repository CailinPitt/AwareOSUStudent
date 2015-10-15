# Mechanize gets the website and transforms into HTML file.
require 'mechanize'
# Nokogiri gets the website data that could be read later on.
require 'nokogiri'

def main
	yesterday = (Time.now - (3600 * 24)).strftime("%m/%d/%Y")
	agent = Mechanize.new

	# Chose Safari because I like Macs
	agent.user_agent_alias = "Mac Safari" 
		
	# Direct to Columbus PD report website
	page = agent.get "http://www.columbuspolice.org/reports/SearchLocation?loc=zon4"

	search_form = page.form_with :id => "ctl01"
	search_form.field_with(:name => "ctl00$MainContent$startdate").value = yesterday
	search_form.field_with(:name => "ctl00$MainContent$enddate").value = yesterday
	# Searching for all crimes from yesterday

	button = search_form.button_with(:type => "submit")
	# Get button in order to submit search

	search_results = agent.submit(search_form, button)
	# Page containing the information we want to sift through.
	# Time for Nokogiri

	puts search_results.body
end

main