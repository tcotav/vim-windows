vim-windows Cookbook
====================
Rudimentary vim cookbook for windows

reference: http://sourceforge.net/apps/trac/unattended/wiki/Gvim

Requirements
------------
#### packages
- `windows` - vim-windows needs windows 

Attributes
----------
#### vim-windows::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['vim']['windows']['source']['url']</tt></td>
    <td>String</td>
    <td>source url of CREAM vim .exe</td>
  </tr>
  <tr>
    <td><tt>['vim']['windows']['source']['checksum']</tt></td>
    <td>String</td>
    <td>checksum of .exe file</td>
  </tr>

</table>

Usage
-----
#### vim-windows::default
Just include `vim-windows` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[windows]"
    "recipe[vim-windows]"
  ]
}
```

License and Authors
-------------------
Authors:  james francis (tcotav, tcotav@gmail.com)
