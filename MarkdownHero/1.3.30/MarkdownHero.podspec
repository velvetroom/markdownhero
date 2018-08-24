Pod::Spec.new do |s|
s.name             = 'MarkdownHero'
s.version          = '1.3.30'
s.summary          = 'Parse markdown'
s.description      = <<-DESC
From markdown to attributed string
DESC
s.homepage         = 'https://github.com/velvetroom/markdownhero'
s.license          = { :type => "MIT", :file => "LICENSE" }
s.author           = { 'iturbide' => 'markdownhero@iturbi.de' }
s.platform         = :ios, '9.0'
s.source           = { :git => 'https://github.com/velvetroom/markdownhero.git', :tag => "v#{s.version}" }
s.source_files     = 'Source/*.swift'
s.swift_version    = '4.1'
s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
s.prefix_header_file = false
s.static_framework = true
end
