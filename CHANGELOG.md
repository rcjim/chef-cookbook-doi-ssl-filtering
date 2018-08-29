# CHANGELOG

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [UNRELEASED]
- [jmorris@usgs.gov] - Added resource java_keytool_management for importing certs into Java
- [jmorris@usgs.gov] - Added Java 10 to the Kitchen test suite
- [jmorris@usgs.gov] - Added Windows support to the ruby recipe and inspec tests
### Removed
- [jmorris@usgs.gov] - Removed Test Kitchen "default" test suite
### Updated
- [jmorris@usgs.gov] - Updated serverspec tests
- [jmorris@usgs.gov] - Switched changelog format
- [jmorris@usgs.gov] - Updated Test Kitchen for CentOS 6/7
- [jmorris@usgs.gov] - Updated Test Kitchen to use Java 8
- [jmorris@usgs.gov] - Updated Test Kitchen to use ruby recipe instead of the deprecated kitchen recipe
- [jmorris@usgs.gov] - Updated tests to use the provided rootCA Cert
- [jmorris@usgs.gov] - Various Rubocop style changes
- [jmorris@usgs.gov] - Use SHA1 or SHA256 for the fingerprint matching
- [jmorris@usgs.gov] - Updated metadata.platforms for CentOS 6.8+ and 7.0+
- [jmorris@usgs.gov] - Renamed windows test suite to be ruby-win
- [jmorris@usgs.gov] - Switched windows test suite from serverspec to inspec
- [jmorris@usgs.gov] - Updated ruby inspect test to run on both unix and windows
- [jmorris@usgs.gov] - Updated chefspec test for ruby to check the ruby block

## [1.0.6] - 2017-05-11
### Updated
- [isuftin@usgs.gov] - Relaxed supported Chef version to 12, down from 13

## [1.0.5] - 2017-05-10
### Added
- [isuftin@usgs.gov] - Added inspec testing for the Ruby recipe
- [isuftin@usgs.gov] - Added sample root SSL cert (and key)
- [isuftin@usgs.gov] - Added LICENSE file
- [isuftin@usgs.gov] - Added Travis testing
### Updated
- [isuftin@usgs.gov] - Simplified the way in which to identify the system SSL cert that Ruby uses
- [isuftin@usgs.gov] - Deprecated the Kitchen recipe
- [isuftin@usgs.gov] - Updated metadata.rb to include current standards as per foodcritic

## [1.0.4] - 2017-03-14
### Updated
- [isuftin@usgs.gov] - Removed resource cloning

## [1.0.3] - 2017-03-13
### Updated
- [isuftin@usgs.gov] - Only try to pull down CACert if missing

## [1.0.2] - 2017-03-11
### Updated
- [isuftin@usgs.gov] - Relaxed third party cookbook Java version requirement

## [1.0.1] - 2017-03-01
### Updated
- [isuftin@usgs.gov] - Java recipe now allows alternate locations for keystore
- [isuftin@usgs.gov] - Updated Kitchen configuration to use CentOS 6.8 (was 6.7)
- [isuftin@usgs.gov] - Made community Java cookbook a hard dependency

## [1.0.0] - 2016-10-31
### Updated
- [isuftin@usgs.gov] - Updating cookbook to allow for multiple certificates
- [isuftin@usgs.gov] - Rubocop linting and some refactoring/cleanup

## [0.0.3] - 2016-09-21
### Added
- [jmorris@usgs.gov] - Added support for windows

## [0.0.2] - 2016-08-19
### Added
- [isuftin@usgs.gov] - Add fix for Java trust store and SSL certificate. Tested on both Oracle and OpenJDK

## [0.0.1] - 2016-08-11
### Added
- [isuftin@usgs.gov] - Initial release
- [isuftin@usgs.gov] - Add fixes for OpenSSL and Test Kitchen
