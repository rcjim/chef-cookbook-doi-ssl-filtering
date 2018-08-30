DOI SSL Filtering Fixes Cookbook
================================

This cookbook provides fixes which update OpenSSL, Ruby and Java installations to
include needed SSL certificates.

This is helpful when creating virtual machines on a network that performs SSL
interception or testing virtual machines via Test Kitchen.

This is currently only tested with CentOS 6.x and 7.x.

In order to get the certificate on the target machine, the
`certificate` recipe needs to be run. This recipe will check the
remote URL or local file system for the existence of and updates to
your list of SSL root certificates you wish to import. There is no
default certificate specified in the attributes. To set certificate
locations either remotely or on the local file system, set the array
of attribute values for `['doi_ssl_filtering']['cert_location']` to
either an `http://`, `https://` or `file://` address.

To fix openssl on the target system which fixes utilities like curl,
run the `openssl` recipe after running the `certificate` recipe.

To fix issues with system Ruby, run the `ruby` recipe. This fixes the
embedded Ruby installation on the target system so if recipes attempt
to pull down data via Ruby's OpenSSL implementation, it should not
break.

Running the `default` recipe will first pull down the certificate by
running the `certificate` recipe and will then go on to fix openssl
and test kitchen installations.

## Resources

### java_keytool_management

The java_keytool_management resource adds the certificate(s) to the java
certificate store cacerts

#### Properties

* `cert_alias`, String. An alternate name for the certificate being imported
* `certificate`, String. The certificate to import
* `keystore`, String. The keystore location. For windows,
                      one of MY, CA, ROOT, TRUSTEDPUBLISHER, CLIENTAUTHISSUER,
                      REMOTEDESKTOP, TRUSTEDDEVICES, WEBHOSTING, AUTHROOT,
                      TRUSTEDPEOPLE, SMARTCARDROOT, and TRUST
* `storepass`, String. The password used to protect the keystore. Ignored for windows

## Integration Testing

This cookbook uses
[test-kitchen](https://github.com/test-kitchen/test-kitchen) for
integration tests. The test for windows was performed on a private
image created by using this
[Packer Template](https://github.com/boxcutter/windows). The vagrant-winrm
plugin (`vagrant plugin install vagrant-winrm`) may need to be
installed to run the integration tests.

