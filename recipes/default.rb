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


#  http://sourceforge.net/projects/cream/files/Vim/7.3.829/gvim-7-3-829.exe/download


###########################################################
# drupal install
sourcepath=::File.join(Chef::Config[:file_cache_path], "gvim")
gvimexe=::File.join(sourcepath,"gvim-latest.exe")
mpath="c:/Program Files (x86)/Vim"

# source directory where we land and unroll our zip
directory sourcepath do
  action :create
end


# distfile
remote_file gvimexe do
  source node['vim']['windows']['source']['url']
  checksum node['vim']['windows']['source']['checksum']
end

windows_batch "gvimexe-run" do
  code <<-EOH
    #{gvimexe.gsub('/', '\\')} /S
  EOH
  not_if do
    ::File.exists?(mpath)
  end
end
