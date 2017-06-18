require 'json'

class ConfigParser
  def initialize(paths=nil)
    if paths.nil?
      @files = []
    else
      @files = paths
    end

    @supported_types = {:int => "i",
                        :float => "f",
                        :string => "s"}
  end

  def register(file)
    @files << file unless @files.include? file
  end

  def deregister(file)
    !!@files.delete(file)
  end

  def get(value, type=:string)
    JSON.parse(File.new(@files[0]).read())[value].send(:"to_#{@supported_types[type]}")
  end
end
