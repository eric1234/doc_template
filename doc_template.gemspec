Gem::Specification.new do |s|
  s.name = 'doc_template'
  s.version = '0.0.1'
  s.author = 'Eric Anderson'
  s.email = 'eric@pixelwareinc.com'
  s.add_dependency 'zipruby'
  s.add_dependency 'nokogiri'
  s.add_development_dependency 'rake'
  s.files = Dir['**/*'].reject do |f|
    f =~ /^test/ || f =~ /^pkg/
  end
  s.has_rdoc = true
  s.extra_rdoc_files << 'README.rdoc'
  s.rdoc_options << '--main' << 'README.rdoc'
  s.summary = 'Simple Office Document Templating'
  s.description = <<-DESCRIPTION
    Provides an ability to pre-populate an office document through a simple
    templating mechanism that can easily be managed by an end user.
  DESCRIPTION
end
