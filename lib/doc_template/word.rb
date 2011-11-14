# Finding the correct thing to change and making the update abstracted to
# this class so that Word-specific behavior is isolated. This will make it
# easier to later add support for other document types using markers that make
# sense for it.
class DocTemplate::Word

  # The entries in the zip file that should be processed
  CONTENT_ENTRIES = %w(word/document.xml)

  def populate(dom, data)
    dom.xpath('//w:sdt//w:t').each do |field|
      field.content = data[field.content]
    end
  end

end

# Register this with the system so it know to call it for word docs
DocTemplate.register_format DocTemplate::Word, 'docx'