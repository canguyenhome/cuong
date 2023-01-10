require 'test_helper'

class HierarchyTest < ActiveSupport::TestCase
  def setup
   @technology = Technology.new(name: 'Technology')
   @category = Category.new(name: 'Category')
   @hierarchy = @technology.hierarchies.build(category_id: @category.id)
  end
  
  test "should be valid" do
    assert @hierarchy.valid?
  end
end
