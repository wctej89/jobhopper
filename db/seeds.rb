
file = File.expand_path('../shit.csv', __FILE__)
lines = File.open(file).readlines
lines.each do |line|
  values = line.strip.split(',')
  Zip.create(:zip_code => values[0], :url => values[1])
end
