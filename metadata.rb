name 'doi_ssl_filtering'
maintainer 'Ivan Suftin'
maintainer_email 'isuftin@gmail.com'
license 'Public Domain'
description 'Installs/Configures openssl and ruby applications for DOI SSL filtering using DOI root certificate'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'https://github.com/USGS-CIDA/chef-cookbook-doi-ssl-filtering/issues'
source_url 'https://github.com/USGS-CIDA/chef-cookbook-doi-ssl-filtering'
version '1.0.3'

depends 'windows', '>= 1.44.3'
depends 'java'
