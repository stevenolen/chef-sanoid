# spec/support/matchers.rb
def custom_accumulator_matcher(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:accumulator, :create, resource_name)
end
