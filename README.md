# sanoid-cookbook

## Description

A chef cookbook which provides an LWRP interface for the [sanoid](https://github.com/jimsalterjrs/sanoid) tool (for making snapshots with ZFS).  Additionally the `sanoid::default` recipe installs the latest sanoid and syncoid to the system. Thanks to [chef-accumulator](https://github.com/kisoku/chef-accumulator) and [opscode-backup](https://github.com/opscode-cookbooks/opscode-backup) (for some cookbook design patterns) cookbooks as well as github user [jimsalterjrs](https://github.com/jimsalterjrs) for the snapshot tool!

## Supports

  * FreeBSD
  * Debian-alike, Red Hat-alike (zfs_on_linux or some other way to get `zfs` command is required)

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['sanoid']['bin_path']</tt></td>
    <td>String</td>
    <td>Location where the sanoid binary will be stored</td>
    <td><tt>`/usr/local/bin`</tt></td>
  </tr>
  <tr>
    <td><tt>['sanoid']['conf_path']</tt></td>
    <td>String</td>
    <td>Location where the sanoid conf file will be stored</td>
    <td><tt>`/etc/sanoid/`</tt></td>
  </tr>
  <tr>
    <td><tt>['sanoid']['user']</tt></td>
    <td>String</td>
    <td>Value of user to run sanoid as.</td>
    <td><tt>`root`</tt></td>
  </tr>
  <tr>
    <td><tt>['sanoid']['group']</tt></td>
    <td>String</td>
    <td>Value of group to own sanoid files.</td>
    <td><tt>Debian,RedHat: root, FreeBSD: wheel</tt></td>
  </tr>
</table>

## Resources Overview

### sanoid_dataset

The `sanoid_dataset` resource manages a snapshot model. It requires only a name and template to use (as `use_template`), but you may override any template settings for only this model as needed

#### Example
```
sanoid_dataset 'zpool/test' do
  use_template "default"
end
```
Please note that the zfs dataset must already exist, or sanoid will fail to make a snapshot for it!

### sanoid_template

The `sanoid_template` resource manages a sanoid template. You can use any existing setting for snapshot timings/count here (TODO: monitoring support). Note that you should not use a template named `default` as it is already provided from the sanoid.conf file with some sane defaults.  

#### Example
```
sanoid_template 'backup' do
  hourly 30
  daily 1
  monthly 1
  yearly 1
  autosnap "yes"
  autoprune "yes"
end
```

### sanoid_syncoid

The `sanoid_syncoid` resource manages a syncoid cron job. It currently only supports a local source, remote target, because in a chef environment, you can easily just apply the opposite resource to the remote server if you'd like the reverse to occur. The user defaults to `node['sanoid']['user']` which may be quite different for you, so feel free to override it. The cron attribute follows the `min hour day month weekday` format, and the default results in one sync daily at midnight (eg. `0 0 * * *`). Also supports deletion of a job with `action :delete`.

#### Example
```
sanoid_syncoid 'backup' do
  user
  server "backup.server.com"
  dataset "zroot/tmp"
  target "backup/zroot/tmp"
  cron "0 0 * * *"
end
```


## License and Authors

Author:: Steve Nolen (technolengy@gmail.com)

```
Copright:: 2015 Steve Nolen

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.