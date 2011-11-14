require 'test/unit'
require 'pathname'

require Pathname.new(__FILE__).dirname.join('../lib/doc_template').to_s

class Test::Unit::TestCase

  def fixture(file)
    Pathname.new(__FILE__).dirname.join('fixtures', file).to_s
  end

end