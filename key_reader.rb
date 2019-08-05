# frozen_string_literal: true

def read_key(file_name)
  pk, sk = nil
  File.open(file_name, 'r') do |f|
    pk = f.readline
    sk = f.readline
  end
  { pk: pk, sk: sk }
end

# puts read_key('apiKeys.txt')
