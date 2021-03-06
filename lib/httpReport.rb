require 'net/http'
require 'json'

def start_program
  STDOUT.puts "Please type in a url"
  input = STDIN.gets.chomp
  @input_array = input.split("\\n")
end

def invalid_url_chars(website)
  @invalid_url_chars = false
  valid_characters_array = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~:/?#[]@!$&'()*+,;=".split("")
  website.split("").each do |char|
    @invalid_url_chars = true if !valid_characters_array.include?(char)
  end
  @invalid_url_chars
end

def invalid_url_start(website)
  valid_url_beginning = /^https?:\/\//
  website.scan(valid_url_beginning).length != 1
end

def print_error(website)
  STDERR.puts JSON.generate({"Url": "#{website}", "Error": "invalid url"})
end

def print_JSON(website)
  res = Net::HTTP.get_response(URI(website))
  STDOUT.puts JSON.generate({"Url": "#{URI(website)}", "Status_code": "#{res.code}", "Content_length": "#{res["content-length"]}", "Date": "#{res["date"]}"})
end

start_program

report(@input_array)