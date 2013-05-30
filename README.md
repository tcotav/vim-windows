vim-windows Cookbook
====================
Vim cookbook for Windows (how else are you going to edit your files?)

Uses Cream sub project of vim: http://cream.sourceforge.net/ for vim binary.

Includes:
- batch files allowing vim or gvim invocation from command line
- 'Edit with Vim' right click menu option



Requirements
------------
#### packages
- `chef_handler`
- `windows`
- `powershell`

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
  <tr>
    <td><tt>['vim']['install']['basedir']</tt></td>
    <td>String</td>
    <td>base install dir for vim -- usually 'c:\\Program Files\\Vim' or
'c:\\Program Files (x86)\\Vim'.  used in registry file.</td>
  </tr>
  <tr>
    <td><tt>['vim']['install']['versiondir'] = 'vim73' </tt></td>
    <td>String</td>
    <td>version subdir of ['basedir'] above -- ex. 'vim73'.  used in
registry file.</td>
  </tr>

</table>

Usage
-----
#### vim-windows::default
Just include `vim-windows` in your node's `run_list` along with the
following:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[chef-handler]"
    "recipe[windows]"
    "recipe[powershell]"
    "recipe[vim-windows]"
  ]
}
```

License and Authors
-------------------
Authors:  james francis (tcotav, tcotav@gmail.com)
