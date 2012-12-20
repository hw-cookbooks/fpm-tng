default[:fpm_tng][:install][:gems] = %w(fpm)
default[:fpm_tng][:install][:packages] = []
default[:fpm_tng][:build_dir] = '/opt/fpm-build'
default[:fpm_tng][:package_dir] = '/opt/fpm-pkgs'
default[:fpm_tng][:exec] = File.join(node.languages.ruby.bin_dir, 'fpm')
default[:fpm_tng][:gem] = File.join(node.languages.ruby.bin_dir, 'gem')
