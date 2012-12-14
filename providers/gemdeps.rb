
action :create do
  require 'rubygems/dependency_installer'
  args = [new_resource.name, new_resource.version].compact
  dep_installer = Gem::DependencyInstaller.new
  base = dep_installer.find_spec_by_name_and_version(*args).flatten.first
  pk_list = []
  updated = false
  unless(base)
    raise "Failed to locate requested gem for dependency building: #{args.join(' - ')}"
  end
  resource_generator = lambda do |base_spec|
    base_spec.runtime_dependencies.each do |dep|
      spec = dep_installer.find_gems_with_sources(dep).last.first
      s_name = [new_resource.gem_package_name_prefix, spec.name].join('-')
      next if pk_list.include?(s_name)
      pk_list << s_name
      f = fpm_tng_package s_name do
        input_type 'gem'
        output_type 'deb'
        gem_gem new_resource.gem_gem
        version spec.version.to_s
        gem_package_name_prefix new_resource.gem_package_name_prefix
        gem_fix_name false
        input_args spec.name
        reprepro new_resource.reprepro
      end
      f.run_action(:create)
      updated ||= f.updated_by_last_action?
      spec.runtime_dependencies.each do |s|
        resource_generator.call(dep_installer.find_gems_with_sources(s).last.first)
      end
    end
  end
  resource_generator.call(base)
  new_resource.updated_by_last_action(updated)
end
