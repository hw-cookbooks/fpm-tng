actions :create, :delete
default_action :create

# Helper stuffs
attribute :reprepro, :kind_of => [TrueClass,FalseClass], :default => false
attribute :creates, :kind_of => String

attribute :input_args, :kind_of => [String,Array], :default => '.'
attribute :input_type, :kind_of => String, :default => 'dir'
attribute :output_type, :kind_of => String, :required => true
attribute :chdir, :kind_of => String
attribute :package_name, :kind_of => String

# FPM args

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
