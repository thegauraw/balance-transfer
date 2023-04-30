module CsvUtils
  def self.write_hash_to_csv_file(data_hashes, filepath)
    csv_headers = data_hashes.first.keys
    CSV.open(filepath, "w", headers: csv_headers, write_headers: true) do |csv|
      data_hashes.each do |h|
        csv << h.values
      end
    end
  end
end