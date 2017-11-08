Zammad Cookbook
================

[![Build Status](https://travis-ci.org/WIU/zammad.svg?branch=master)](https://travis-ci.org/WIU/zammad)
[![Cookbook Version](https://img.shields.io/cookbook/v/zammad.svg)](https://supermarket.chef.io/cookbooks/zammad)

Installs and configures a [Zammad](https://zammad.org/) server.  Zammad is a web-based, open source user support/ticketing solution.


Requirements
------------

#### Chef

* Chef 12.5+

#### Platforms

* RHEL 7+

**Notes**: This cookbook has been tested on the listed platforms. It may work on other platforms with or without modification.

#### Cookbooks
* Elasticsearch
* Java
* Nginx
* Postfix
* Sysctl
* Yum-EPEL

Attributes
----------
### default
Linux default attributes

* `node['java']['jdk_version']` - Java version, default 'OpenJDK 8'
* `node['postfix']['main']['relayhost']` - Relayhost for Postfix when default['zammad']['local_mta'] = true, default 'smtp.example.com'
* `node['zammad']['local_mta']` - Setup a local Postfix MTA for Zammad, default 'true'
* `node['zammad']['local_es']` - Setup a local Elasticsearch for Zammad, default 'true'
* `node['zammad']['use_proxy']` - Use the Chef http_proxy when downloading ES plugins, default 'false'
* `node['zammad']['nginx_server_name']` - Server name to use in the Nginx zammad.conf file, default 'localhost'

Recipes
-------
### default
Includes the `zammad::elasticsearch` and/or `postfix` recipes depending on whether they are enabled via attributes.

### elasticsearch
Configures the node to run elasticsearch locally.  Generates a generic ES setup based on the defaults in the Elasticsearch cookbook.  It also runs two rake commands to complete the ES setup for Zammad.

Usage
-----

The default recipe will:

- Setup Zammad Repo
- Install Java
- Install Nginx and deploy a default zammad.conf from the template
- Install Zammad
- Install and setup an Elasticsearch cluster, optional
- Install and setup Postfix MTA, optional

If you want to install the default Elasticsearch cluster, set the `default['zammad']['local_es']` to `true`.  Use of an exteral Elasticsearch server is supported but currently out of the scope of this cookbook.

If you want to setup the local Postfix MTA for Zammad to use, set the `default['zammad']['local_mta']` to `true`.  If you'd rather setup Zammad to use an external SMTP server, set this to `false`.