require 'pathname'
require Pathname.new(__FILE__).dirname.join('test_helper').to_s

class DocTemplateTest < Test::Unit::TestCase

  # Make sure initial data can be passed in if desired
  def test_initialization
    t = DocTemplate.new fixture('test.docx'), 'N/A'
    assert_equal 'N/A', t['fake']
  end

  # Make sure template behaves like a hash
  def test_hash_behavior
    t = DocTemplate.new fixture('test.docx')

    assert_equal 0, t.size

    t['key'] = 'value'
    assert_equal 'value', t['key']

    t.merge!({'another_key' => 'another_value'})
    assert_equal 'another_value', t['another_key']

    assert_equal 2, t.size
    t.clear
    assert_equal 0, t.size
  end

  # Make sure a format can be registered
  def test_registration
    DocTemplate.register_format Object, 'ext1', 'ext2'
    assert_equal Object, DocTemplate::FORMATS['ext1']
    assert_equal Object, DocTemplate::FORMATS['ext2']
  end

  def test_save_as
    t = DocTemplate.new fixture('test.docx')
    t['First name'] = 'Joe'
    t['last_name'] = 'Blow'
    t['message'] = 'Some text here'
    t.save_as fixture('actual.docx')
    assert_docs_equal fixture('expected.docx'), fixture('actual.docx')
  ensure
    FileUtils.rm fixture('actual.docx')
  end

  private

  def assert_docs_equal(expected, actual)
    assert_equal doc_xml(expected), doc_xml(actual)
  end

  # We can only compare the XML files since zipping changes some properties.
  def doc_xml(file)
    content = nil
    Zip::Archive.open(file) do |archive|
      archive.fopen('word/document.xml') do |f|
        content = f.read
      end
    end
    content
  end

end