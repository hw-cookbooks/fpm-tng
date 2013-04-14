
action :create do

  ignore_attrs = %w(input_type output_type version input_args gem_fix_name)
  
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
    all_deps = []
    base_spec.runtime_dependencies.each do |dep|
      dep_res = []
      spec = dep_installer.find_gems_with_sources(dep).last.first
      deps = spec.runtime_dependencies.map do |s|
        dep_res = resource_generator.call(dep_installer.find_gems_with_sources(s).last.first)
      end

      s_name = [new_resource.gem_package_name_prefix, new_resource.package_name_suffix, spec.name].compact.join('-')

      next if pk_list.include?(s_name)
      pk_list << s_name
      f = fpm_tng_package s_name do
        input_type 'gem'
        output_type 'deb'
        gem_fix_name false
        input_args spec.name
        version spec.version.to_s
        depends dep_res.map(&:first) unless dep_res.empty?
        (FpmTng::STRINGS + FpmTng::NUMERICS + FpmTng::STRING_ARRAYS + FpmTng::TRUE_FALSE).each do |attr|
          next if ignore_attrs.include?(attr)
          if(new_resource.send(attr))
            self.send(attr, new_resource.send(attr))
          end
        end
      end
      f.run_action(:create)
      updated ||= f.updated_by_last_action?
      all_deps += [[s_name, spec.version]] + dep_res
    end
    all_deps
  end
  dependencies = resource_generator.call(base)
  new_resource.generated_dependencies(
    dependencies.map(&:first) # TODO: Need to think more about version restrictions
  )
  new_resource.updated_by_last_action(updated)
end
