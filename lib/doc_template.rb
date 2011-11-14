require 'fileutils'
require 'zipruby'
require 'nokogiri'

# Inherit from Hash so that the attributes being assigned to the template
# can be managed using all the goodies that Hash provides
# (i.e. [], []=, merge, clear), etc.
class DocTemplate < Hash
  FORMATS = {}

  def self.register_format(format, *extensions)
    for extension in extensions
      FORMATS[extension] = format
    end
  end

  # Filename is the template file. The rest of the args will be passed onto
  # the hash so you can initialize the attributes in any method you want.
  def initialize(filename, *args, &blk)
    @filename = filename
    super(*args, &blk)
  end

  def save_as(output_file, data={})
    FileUtils.cp @filename, output_file
    Zip::Archive.open(output_file) do |archive|
      format.const_get(:CONTENT_ENTRIES).each do |entry|
        archive.fopen(entry) do |file|
          dom = Nokogiri::XML file.read
          format.new.populate dom, self
          archive.replace_buffer entry, dom.to_s
        end
      end
    end
  end

  private

  # Returns the format object for the document being processed
  def format
    FORMATS[File.extname(@filename)[1..-1]]
  end

end

require 'doc_template/word'