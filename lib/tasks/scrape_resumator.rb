File.read('resumator_clients.txt').split("\n").each do |name|
    puts name
    `curl "http://app.theresumator.com/feeds/export/jobs/#{name}" > "resumator_xml_files/#{name}_xml"`
  end