module RequestHelpers

  FILTERED_FIELDS = ['updated_at'].freeze
  CAPTURE_BASE_PATH = 'spec/captures'.freeze

  def verify_endpoint(path)
    get path
    raw_body = response.body
    raw_expected = read_or_write_capture(path, raw_body)
    compare_response(raw_body, raw_expected)
  end

  private

  def read_or_write_capture(path, raw_body)
    file_name = "#{path.parameterize}.json"
    begin
      read_capture(file_name)
    rescue Errno::ENOENT
      write_capture(file_name, raw_body)
    end
  end

  def read_capture(file_name)
    File.read(File.join(CAPTURE_BASE_PATH, file_name))
  end

  def write_capture(file_name, raw_body)
    parsed_body = JSON.parse(raw_body)
    JSON.pretty_generate(parsed_body).tap do |pretty_json|
      File.write(File.join(CAPTURE_BASE_PATH, file_name), pretty_json)
    end
  end

  def compare_response(raw_body, raw_expected)
    parsed_body = filter(JSON.parse(raw_body))
    parsed_expected = filter(JSON.parse(raw_expected))
    expect(parsed_body).to eq(parsed_expected)
  end

  # Remove filtered fields and order keys to make comparisons easier
  def filter(hash)
    hash.keys.sort.each_with_object({}) do |key, hsh|
      value = hash[key]

      hsh[key] = if value.is_a?(Hash)
        filter(value)
      elsif value.is_a?(Array)
        value.map do |elem|
          filter(elem)
        end
      elsif FILTERED_FIELDS.include?(key)
        :filtered
      else
        value
      end
    end
  end

end