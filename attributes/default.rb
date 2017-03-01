# Set this to a remote web location or a file on the file system
# http://...
# or
# file:///path/to/file
default['doi_ssl_filtering']['cert_locations'] = [
  'http://blockpage.doi.gov/images/DOIRootCA.crt'
]

# Java
# The Java keystore as installed by default has a password (usually 'changeit').
# This password is stored in an encrypted databag. If the data bag does not exist
# in your cookbook, the default 'changeit' password will be used
default['doi_ssl_filtering']['encrypted_data_bag_name'] = 'doi_ssl_filtering_default'

# If this is left blank, the default keystore that will be used will be:
# $JAVA_HOME/jre/lib/security/cacerts
default['doi_ssl_filtering']['java']['location']['keystore'] = ''
