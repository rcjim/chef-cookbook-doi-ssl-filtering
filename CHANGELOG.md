DOI SSL Filtering
=================

v1.0.6
------
- [isuftin@usgs.gov] - Relaxed supported Chef version to 12, down from 13

v1.0.5
------
- [isuftin@usgs.gov] - Simplified the way in which to identify the system SSL cert
	that Ruby uses
- [isuftin@usgs.gov] - Added inspec testing for the Ruby recipe
- [isuftin@usgs.gov] - Deprecated the Kitchen recipe
- [isuftin@usgs.gov] - Added sample root SSL cert (and key)
- [isuftin@usgs.gov] - Added LICENSE file
- [isuftin@usgs.gov] - Updated metadata.rb to include current standards as per foodcritic
- [isuftin@usgs.gov] - Added Travis testing

v1.0.4
------
- [isuftin@usgs.gov] - Removed resource cloning

v1.0.3
------
- [isuftin@usgs.gov] - Only try to pull down CACert if missing

v1.0.2
------
- [isuftin@usgs.gov] - Relaxed third party cookbook Java version requirement

v1.0.1
------
- [isuftin@usgs.gov] - Java recipe now allows alternate locations for keystore
- [isuftin@usgs.gov] - Updated Kitchen configuration to use CentOS 6.8 (was 6.7)
- [isuftin@usgs.gov] - Made community Java cookbook a hard dependency

v1.0.0
------
- [isuftin@usgs.gov] - Updating cookbook to allow for multiple certificates
- [isuftin@usgs.gov] - Rubocop linting and some refactoring/cleanup

v0.0.3
------
- [jmorris@usgs.gov] - Added support for windows

v0.0.2
------

- [isuftin@usgs.gov] - Add fix for Java trust store and SSL certificate. Tested on both Oracle and OpenJDK

v0.0.1
------

- [isuftin@usgs.gov] - Initial release
- [isuftin@usgs.gov] - Add fixes for OpenSSL and Test Kitchen  
