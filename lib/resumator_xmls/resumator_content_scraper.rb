require 'active_support/all'

#File.read('resumator_clients.txt').split("\n").each do |company_name|

company_jobs = []
xml_dir = 'resumator_xml_files'
Dir.foreach(xml_dir) do |filename|
  next if filename == '.' or filename == '..'
  company_data_xml = open("#{xml_dir}/#{filename}").read
  jobs_hash = Hash.from_xml(company_data_xml)['jobs']

  puts jobs_hash['company']
  puts "-----------------------------------------------------------------------------"

  if jobs_hash['job']
    jobs_hash['job'].each do |job|
      puts job.keys
      puts; puts; puts;
    end
  end

  break
  puts ; puts ;
end
