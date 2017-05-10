DOI SSL Filtering Fixes Cookbook
================================

This cookbook provides fixes which update OpenSSL, Ruby and Java installations to
include needed SSL certificates.

This is helpful when creating virtual machines on a network that performs SSL
interception or testing virtual machines via Test Kitchen.

This is currently only tested with CentOS 6.x.

In order to get the certificate on the target machine, the `certificate` recipe needs to be run. This recipe will check the remote URL or local file system for the existence of and updates to your list of SSL root certificates you wish to import. There is no default certificate specified in the attributes. To set certificate locations either remotely or on the local file system, set the array of attribute values for `['doi_ssl_filtering']['cert_location']` to either an `http://`, `https://` or `file://` address.

To fix openssl on the target system which fixes utilities like curl, run the `openssl` recipe after running the `certificate` recipe.

To fix issues with system Ruby, run the `ruby` recipe. This fixes the embedded Ruby installation on the target system so if recipes attempt to pull down data via Ruby's OpenSSL implementation, it should not break.

Running the `default` recipe will first pull down the certificate by running the `certificate` recipe and will then go on to fix openssl and test kitchen installations.
