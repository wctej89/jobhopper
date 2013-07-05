module Search

  def query_exact(query_string)
    query_string.strip.gsub(/~/, "").gsub(/\W+/, ",").split(",").map! { |k| "#{k}*" }.join("+")
  end

  def fuzzy_query(query_string)
    query_string.strip.gsub(/~/, "").gsub(/\W+/, ",").split(",").map! { |k| "#{k}~0.7" }.join("+")
  end
end