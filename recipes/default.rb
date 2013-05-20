#
# Cookbook Name:: vim-windows
# Recipe:: default
#
# Copyright 2013, tcotav
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

sourcepath=::File.join(Chef::Config[:file_cache_path], "gvim")
gvimexe=::File.join(sourcepath,"cream-latest.exe")
mpath="c:/Program Files (x86)/Vim"

# source directory where we land and unroll our zip
directory sourcepath do
  action :create
end

remote_file gvimexe do
  source node['cream']['windows']['source']['url']
  checksum node['cream']['windows']['source']['checksum']
end

#####################################
# REGEDIT
#
# ref:http://sourceforge.net/apps/trac/unattended/wiki/Gvim
template "#{sourcepath}\\gvim.reg" do
  source 'gvim_reg.erb'
  action :create
  variables ({
    :basedir => node['vim']['install']['basedir'],
    :versiondir => node['vim']['install']['versiondir']
  }
  )
end

# there is windows_registry in windows cookbook, but I thought this was clearer (to win folks)
powershell "regedit-run" do
  code <<-EOH
    regedit /S "#{sourcepath}\\gvim.reg"
  EOH
  not_if {::Registry.key_exists?('HKEY_CLASSES_ROOT\CLSID\{51EEE242-AD87-11d3-9C1E-0090278BBD99}')}
end

# run cream installer
powershell "gvimexe-run" do
  code <<-EOH
    #{gvimexe.gsub('/', '\\')} /S
  EOH
  not_if {::File.exists?(mpath)}
end

##############################
# add shortcuts
#vim_exe='C:\\Program Files (x86)\\vim\\vim73\\gvim.exe'
## add one to desktop
#vim_desktop_lnk= '%HOMEDRIVE%%HOMEPATH%\\Desktop\\vim.lnk'
## and one pinned to taskbar
#vim_taskbar_lnk = '%HOMEDRIVE%%HOMEPATH%\\AppData\\Roaming\\Microsoft\\Internet Explorer\\Quick Launch\\User Pinned'
#windows_batch "create_shortcuts" do
#  code <<-EOH
#    @echo off
#    echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
#    REM add to desktop
#    echo sLinkFile = #{vim_desktop_lnk} >> CreateShortcut.vbs
#    echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
#    echo oLink.TargetPath = #{vim_exe} >> CreateShortcut.vbs
#    echo oLink.Save >> CreateShortcut1.vbs
#    REM add to taskbar
#    echo sLinkFile = #{vim_taskbar_lnk} >> CreateShortcut.vbs
#    echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
#    echo oLink.TargetPath = #{vim_exe} >> CreateShortcut.vbs
#    echo oLink.Save >> CreateShortcut2.vbs
#    cscript CreateShortcut1.vbs
#    cscript CreateShortcut2.vbs
#    del CreateShortcut1.vbs
#    del CreateShortcut2.vbs
#  EOH
#  not_if {::File.exists?(vim_desktop_lnk.gsub('\\', '/'))}
#end


