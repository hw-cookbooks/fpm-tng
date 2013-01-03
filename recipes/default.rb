begin
  resources(:ohai => 'ruby')
  ruby_block 'Reset ruby defaults' do
    block do
      node.default[:fpm_tng][:exec] = File.join(node.languages.ruby.bin_dir, 'fpm')
      node.default[:fpm_tng][:gem] = File.join(node.languages.ruby.bin_dir, 'gem')
    end
    action :nothing
    subscribes :create, 'ohai[ruby]', :immediately
  end
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn 'No ohai ruby reload found.'
end

node[:fpm_tng][:install][:gems].each do |fpm_gem|
  gem_package fpm_gem do
    gem_binary node[:fpm_tng][:gem]
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
