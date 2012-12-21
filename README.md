# fpm-tng

The next generation of effing package management on Chef.

## Usage

This cookbook installs fpm to a given Ruby. It also provides
some useful LWRPs to help build packages in a Chef friendly
manner.

## LWRPs

### fpm_tng_package

Builds a package using fpm. All options available via `fpm --help`
are available as attributes within the LWRP. Dashes are simply
replaced with underscores. For example, lets build a rails gem:

```ruby
fpm_tng_package 'rails' do
  input_type 'gem'
  output_type 'deb'
  version '3.2.6'
  input_args 'rails'
end
```

### fpm_tng_gemdeps

Most times gems will requre dependencies. These can be autobuilt:

fpm_tng_gemdeps 'rails' do
  version '3.2.6'
end

## Attributes

* default[:fpm_tng][:install][:gems] = %w(fpm)
* default[:fpm_tng][:install][:packages] = []
* default[:fpm_tng][:build_dir] = '/opt/fpm-build'
* default[:fpm_tng][:package_dir] = '/opt/fpm-pkgs'
* default[:fpm_tng][:exec] = File.join(node.languages.ruby.bin_dir, 'fpm')
* default[:fpm_tng][:gem] = node.languages.ruby.gem_bin

## Infos
* Repository: https://github.com/hw-cookbooks/fpm-tng
