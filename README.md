# sox

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with sox](#setup)
    * [What sox affects](#what-sox-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with sox](#beginning-with-sox)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module is adds sox compliances checks and example fix classes for managing bringing a machine into compliance.
Tested with RHEL 6.5 and Puppet Enterprise 3.3

## Module Description

This module is a native port of the logic from a series of korn shell compliance scripts. The primary function of the module is introducing a series of [custom facter facs](https://docs.puppetlabs.com/facter/2.2/custom_facts.html) that can conditionally enabled and disabled using the respectively named classes. 
This module contains example fix code that can applied to a system to attempt to bring the machine up to compliance using a series of resources that are designed to be as surgical as possible to mirror the original functionality of the kornshell scripts.

## Setup
This module requires the following facts

| Fact name | Expected Values   |
| --------- | ----------------- |
| likewise  | missing,installed |
| dmz       | true,false        |

These facts are need to be provided for the confine calls and were deamed to be too broad to include in this module.

### What sox affects

This module defaults to managing only internal resources needed for the operation of the facter facts. Each class represents the ported linux function from the original compliance logic. This logic is difficult to centralize using standard puppet paradigms. An example woulc we managing users that need to be locked. These users likely in the case of service accounts should be managed in the module responsible the respective service. Given the need to run this module as a stop gap while those essential system service module are developed, the classes contain stand alond, resources to facilitate the managing of these files. Given puppets catalog model, It is _IMPORTANT_ to understand that these resources will conflict with technology modules designed for setup & configuration. As such it should be understood that fixes in this module were built to be as granular as possible. Often parsing files with tools vendored in Puppet Enterprise. These resources , such as a sysctl resource will conflict if a developer attempts to manage the same setting or the same user in their respective module. To alleviate the migration process, this modules classes rely on parse order dependant checking. This to say that if this module is classified last in the parser order, ir will attempt to use the [defined](https://docs.puppetlabs.com/references/latest/function.html#defined) and [defined_with_params](https://forge.puppetlabs.com/puppetlabs/stdlib) functions to determine if catalog already contains resources that match the sox specifications. There is also an ability in this situation for the module to amend the resources that a third party module may be managing. For instance if the user resource in the module does not specify the password as `!!` a [collector overide](https://docs.puppetlabs.com/puppet/latest/reference/lang_resources.html#amending-attributes-with-a-collector) can be forced using the class parameters. This allows a stop gap to ensure a machine is in a compliant state without modifying the original third party module code. Given puppet currently does not notify when resources have been overridden this likely should only be used in situations where code changes have not yet been merged but security requirements need the sox state to stay consistent.

### Setup Requirements **OPTIONAL**

#### Facter Requirements
Puppet Enterprise 3.3 and higher. Currently all facter facts rely only on  the default ruby libraries which ship with Puppet Enterprise.

Gem/Library requirements Noted solely for information purposes

| Name               | Vendored |
| ------------------ | -------- |
| rubygems           | yes      |
| etc                | yes      |
| facter/util/soxsvc | no[1]    |
| json               | yes      |
| augeas             | yes      |
| yaml               | yes      |


1. Shipped within this module lib/facter directory

#### Facter Requirements

This module has the following dependencies on third party modules:

1. https://forge.puppetlabs.com/puppetlabs/stdlib
2. https://forge.puppetlabs.com/fiddyspence/sysctl
3. https://forge.puppetlabs.com/herculesteam/augeasproviders_core
4. https://forge.puppetlabs.com/herculesteam/augeasproviders_shellvar

Note: This modules are only required if fix code is activated in the respective classes

### Beginning with sox

The sox module vendors a series of ruby facter facts, this list can continue to grow and also expanded to use other languge driven facts using [external facts](http://puppetlabs.com/blog/facter-1-7-introduces-external-facts) as required. Each fact is confined to a sister fact that will enable it. This facts are listed in the table below:

| Sox Reporting Fact         | Sister Containment Fact  |
| -------------------------- | ------------------------ |
| `check_6000tcp`            | `sox_6000tcp`            |
| `check_account_passwds`    | `sox_account_passwds`    |
| `check_boot_services`      | `sox_boot_services`      |
| `check_default_umask`      | `sox_default_umask`      |
| `check_disable_accounts`   | `sox_disable_accounts`   |
| `check_disable_rmmount`    | `sox_disable_rmmount`    |
| `check_fileperms`          | `sox_fileperms`          |
| `check_fstab`              | `sox_fstab`              |
| `check_ftpconfperms`       | `sox_ftpconfperms`       |
| `check_ftplogging`         | `sox_ftplogging`         |
| `check_gdm`                | `sox_gdm`                |
| `check_gui_login`          | `sox_gui_login`          |
| `check_inetd_services`     | `sox_inetd_services`     |
| `check_installed_software` | `sox_installed_software` |
| `check_keyserv`            | `sox_keyserv`            |
| `check_loginlog`           | `sox_loginlog`           |
| `check_network`            | `sox_network`            |
| `check_rmmount`            | `sox_rmmount`            |
| `check_root_login_console` | `sox_root_login_console` |
| `check_root_path`          | `sox_root_path`          |
| `check_sendmail`           | `sox_sendmail`           |
| `check_singleuser`         | `sox_singleuser`         |
| `check_su`                 | `sox_su`                 |
| `check_sulog`              | `sox_sulog`              |
| `check_syslog`             | `sox_syslog`             |
| `check_user_policy`        | `sox_user_policy`        |
| `check_xfs`                | `sox_xfs`                |

The "containment" facts are expected to have the value "enabled" if the sister "check" fact is enabled on this system. All facts are plugin sync'ed by puppet despite being enabled or not, it is the existance or absense of this "containment" which controls is that will return a value during plugin sync.




## Usage

The primary class "sox" controls the list of facts that will be enabled on a subsqent run of facter. This class implemented this control using an class paramater called `exclude_classes`. This paramater is intended to contain class names that are excluded for a given host. Using this module in conjunction with hiera, machines can be restricted from enabling  facts based on the value of this parameter.

#### Example declaration

```puppet
class { 'sox':
  exclude_classes => [ 'sox::sendmail','sox::disable_accounts'],
}
```

In this albeit manual declaration example, the main class list would be pruned of the listed classes. This will purged the containment facts for those respective classes as well, i.e. `sox_sendmail` and `sox_disable_accounts`. Because of the containment facts being purged on disk the check facts i.e. `check_sendmail` and `check_disable_accounts` will no longer be returned on the next puppet run. Given these files are managed during a puppet run, it should be understood that facts will only be confined on the subseqent puppet run. If this causes issues in realtime avaiblity of this data, let it be known that it is possible to configure puppet to submit facts without an entire puppet run using `puppet facts upload`. This is covered in detail [here](https://docs.puppetlabs.com/references/3.3.latest/man/facts.html). This can be tied to a puppet run using the [postrun_command](https://docs.puppetlabs.com/references/latest/configuration.html#postruncommand). Please note however as outlined in the document, this command does not work out of the box and requires auth.conf changes.

After reviewing  [What sox affects](#what-sox-affects) , you can enable the fix classes by declaring the fix paramter and passing it a boolean value.

```puppet
class { 'sox':
   fix => true,
}
```

This can also be done for a given run using the following syntax

```shell
# Please note this is all one line
FACTER_sox_fix=true puppet agent -t
```

If only a given fix is required/desired using [automatic parameter lookup in hiera](https://docs.puppetlabs.com/hiera/1/puppet.html#automatic-parameter-lookup), the fixes can enabled for just given class

```yaml
---
sox::network::fixit: true
```

This can also be done section by section as well
The following would compile a partial catalog containing only resources with the tag 13.1 i.e. `sox::disable_rmmount`

```shell
FACTER_sox_fix=true puppet agent -t --tags '13.1'
```

## Limitations

1. This module currently has only been tested on a RHEL operating system.
2. Currently there is no coloboration between the fix values and the checked values. It would be possible to refact any of the facts to read data in via yaml files that where managed by the classes.
3. At the time of this writing not all tags had been migrated to the classes from the configuration (.conf) files
4. Some puppet code is not idempotent and uses the facts value to achieve idempotentance.


## Release Notes/Contributors/Etc

Zack Smith zack@puppetlabs.com
Josh Beard josh.beard@puppetlabs.com

## Related
Once this information is uploaded to puppetdb the following can be used to establish reports across all nodes

https://github.com/dalen/puppet-puppetdbquery#cli
https://docs.puppetlabs.com/puppetdb/latest/api/query/curl.html
https://docs.puppetlabs.com/puppetdb/2.2/api/query/v3/facts.html
https://docs.puppetlabs.com/mcollective/reference/ui/nodereports.html
