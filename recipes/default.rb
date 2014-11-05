node.default[:fpm_tng][:exec] = File.join(node[:languages][:ruby][:bin_dir], 'fpm')
node.default[:fpm_tng][:gem] = node[:languages][:ruby][:gem_bin]

begin
  resources(:ohai => 'ruby')
  ruby_block 'Reset ruby defaults' do
    block do
      node.default[:fpm_tng][:exec] = File.join(node[:languages][:ruby][:bin_dir], 'fpm')
      node.default[:fpm_tng][:gem] = node[:languages][:ruby][:gem_bin]
    end
    action :nothing
    subscribes :create, 'ohai[ruby]', :immediately
  end
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn 'No ohai ruby reload found.'
end 

unless(node[:fpm_tng][:bundle][:enable])
  node[:fpm_tng][:install][:gems].each do |fpm_gem|
    gem_package fpm_gem do
      gem_binary node[:fpm_tng][:gem]
    end
  end
else
  gem_package 'bundler'
  package 'git'
  
  directory node[:fpm_tng][:bundle][:directory] do
    recursive true
  end

  file File.join(node[:fpm_tng][:bundle][:directory], 'Gemfile') do
    mode 0644
    content "source 'https://rubygems.org'\ngem 'fpm', :git => '#{node[:fpm_tng][:bundle][:git_uri]}', :branch => '#{node[:fpm_tng][:bundle][:branch]}'\n"
    notifies :delete, "file[#{File.join(node[:fpm_tng][:bundle][:directory], 'Gemfile.lock')}]", :immediately
  end

  file File.join(node[:fpm_tng][:bundle][:directory], 'Gemfile.lock') do
    action :nothing
  end
  
  execute 'Install FPM bundle' do
    command 'bundle install --binstubs --path=./vendor'
    cwd node[:fpm_tng][:bundle][:directory]
    creates File.join(node[:fpm_tng][:bundle][:directory], 'Gemfile.lock')
  end
end

node[:fpm_tng][:install][:packages].each do |fpm_package|
  package fpm_package
end

[node[:fpm_tng][:build_dir], node[:fpm_tng][:package_dir]].each do |dir|
  directory dir do
    recursive true
  end
end
