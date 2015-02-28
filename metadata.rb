name             'sanoid'
maintainer       'Steve Nolen'
maintainer_email 'technolengy@gmail.com'
license          'GPL v3'
description      'Installs/Configures sanoid'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.3'

%w(centos debian redhat ubuntu freebsd).each do |os|
  supports os
end

recipe 'default', 'Installs sanoid from github'

depends 'accumulator'
depends 'perl'