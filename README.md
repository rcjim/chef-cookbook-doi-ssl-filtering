DOI SSL Filtering Fixes Cookbook
================================

This cookbook provides fixes which update OpenSSL and Test Kitchen installations to include the DOI root certificate.

This is helpful when creating virtual machines on the DOI network or testing virtual machines via Test Kitchen.

This is currently only tested with CentOS 6.x.

In order to get the certificate on the target machine, the `certificate` recipe needs to be run. This recipe will check the remote URL or local file system for the existence of and updates for the DOI root certificate. This certificate can be attained directly from [the DOI](http://blockpage.doi.gov/images/DOIRootCA.crt) and is the default attainment method in this cookbook. To set a different location either remotely or on the local file system, set the attribute value for `['doi_ssl_filtering']['cert_location']` to either an `http://`, `https://` or `file://` address.

To fix openssl on the target system which fixes utilities like curl, run the `openssl` recipe after running the `certificate` recipe. 

To fix issues with Test Kitchen, run the `kitchen` recipe. This fixes the embedded Ruby installation on the target system so if recipes attempt to pull down data via Ruby's OpenSSL implementation, it should not break.

Running the `default` recipe will first pull down the certificate by running the `certificate` recipe and will then go on to fix openssl and test kitchen installations. 