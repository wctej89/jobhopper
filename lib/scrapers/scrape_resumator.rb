require 'json'
require 'open-uri'
require 'active_support/all'

range = ARGV[0].scan(/\d+/).map!(&:to_i)

comp_file = File.open(ARGV[1],'r')

companies = comp_file.readlines(&:chomp)[range[0]...range[1]]

resumator_company_file = File.open('resumator_clients.txt','a+')

companies.each_with_index do |company, i|
  puts i
  begin
    sleep(0.1) 
    company_data = Hash.from_xml(open("http://app.theresumator.com/feeds/export/jobs/#{company}").read)
  rescue Exception => e
    company_data = {}
    puts e.message
    next
  end
  if company_data['jobs']['job']
    resumator_company_file << company
    puts company
  end
end
  
  
