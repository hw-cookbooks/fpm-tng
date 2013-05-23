module FpmTng
  STRINGS = %w(
    prefix license vendor category architecture maintainer
    package_name_suffix description url inputs before_install
    after_install before_remove after_remove workdir gem_bin_path
    gem_package_name_prefix gem_gem deb_compression deb_custom_control
    deb_config deb_templates deb_installed_size deb_priority deb_user
    deb_group deb_changelog rpm_user rpm_group rpm_rpmbuild_define
    rpm_digest rpm_compression rpm_os rpm_changelog python_bin
    python_easyinstall python_pip python_pypi python_package_name_prefix
    python_install_bin python_install_lib python_install_data
    pear_package_name_prefix pear_channel version iteration package
  )
  NUMERICS = %w(epoch)
  STRING_ARRAYS = %w(
    depends provides conflicts replaces config_files directories exclude
    template_value deb_pre_depends
  )
  TRUE_FALSE = %w(
    template_scripts gem_fix_name gem_fix_dependencies 
    deb_ignore_iteration_in_dependencies python_fix_name
    python_fix_dependencies pear_channel_update auto_depends
  )
end
