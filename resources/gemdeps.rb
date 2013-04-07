# TODO: Remove to unwind this in the same fashion?

actions :create
default_action :create

attribute :version, :kind_of => String
attribute :gem_package_name_prefix, :kind_of => String
attribute :gem_gem, :kind_of => String
attribute :reprepro, :kind_of => [TrueClass,FalseClass]
attribute :repository, :kind_of => String

FpmTng::STRINGS.each do |attr|
  attribute attr, :kind_of => String
end

FpmTng::NUMERICS.each do |attr|
  attribute attr, :kind_of => Numeric
end

FpmTng::STRING_ARRAYS.each do |attr|
  attribute attr, :kind_of => [String,Array]
end

FpmTng::TRUE_FALSE.each do |attr|
  attribute attr, :kind_of => [TrueClass,FalseClass]
end
