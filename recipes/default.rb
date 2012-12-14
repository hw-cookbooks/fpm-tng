node[:fpm_tng][:install][:gems].each do |fpm_gem|
  gem_package fpm_gem
end

node[:fpm_tng][:install][:packages].each do |fpm_package|
  package fpm_package
end

[node[:fpm_tng][:build_dir], node[:fpm_tng][:package_dir]].each do |dir|
  directory dir do
    recursive true
  end
end
