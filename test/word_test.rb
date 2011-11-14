require 'pathname'
require Pathname.new(__FILE__).dirname.join('test_helper').to_s

class WordTest < Test::Unit::TestCase

  def test_populate
    dom = Nokogiri::XML(template)
    DocTemplate::Word.new.populate(dom, {'message' => 'replaced'})
    assert_equal expected, dom.to_s
  end

  private

  def template
    <<DOC
<?xml version="1.0" encoding="UTF-8"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:body>
    <w:sdt>
      <w:sdtpr>
        <w:id w:val="1866406817"/>
        <w:placeholder>
          <w:docpart w:val="DefaultPlaceholder_1082065158"/>
        </w:placeholder>
        <w:text/>
      </w:sdtpr>
      <w:sdtcontent>
        <w:p w:rsidr="001E2BFF" w:rsidrdefault="001E2BFF">
          <w:prooferr w:type="gramStart"/>
          <w:r>
            <w:t>message</w:t>
          </w:r>
          <w:prooferr w:type="gramEnd"/>
        </w:p>
      </w:sdtcontent>
    </w:sdt>
  </w:body>
</w:document>
DOC
  end

  def expected
    <<DOC
<?xml version="1.0" encoding="UTF-8"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
  <w:body>
    <w:sdt>
      <w:sdtpr>
        <w:id w:val="1866406817"/>
        <w:placeholder>
          <w:docpart w:val="DefaultPlaceholder_1082065158"/>
        </w:placeholder>
        <w:text/>
      </w:sdtpr>
      <w:sdtcontent>
        <w:p w:rsidr="001E2BFF" w:rsidrdefault="001E2BFF">
          <w:prooferr w:type="gramStart"/>
          <w:r>
            <w:t>replaced</w:t>
          </w:r>
          <w:prooferr w:type="gramEnd"/>
        </w:p>
      </w:sdtcontent>
    </w:sdt>
  </w:body>
</w:document>
DOC
  end

end