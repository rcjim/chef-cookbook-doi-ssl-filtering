#
# Cookbook Name:: doi_ssl_filtering
# Recipe:: default
#

include_recipe "doi_ssl_filtering::certificate"
include_recipe "doi_ssl_filtering::openssl"
include_recipe "doi_ssl_filtering::kitchen"
