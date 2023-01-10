require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  def setup
   @technology = Technology.new(name: 'Technology')
   @category = Category.new(name: 'Category')
   @hierarchy = Hierarchy.new(
     technology_id: @technology.id, 
     category_id: @category.id,
   )
   @repository = @hierarchy.repositories.build(
     owner: "owner", 
     name: "name",
   )
  end
 
 test "should be valid" do
    assert @repository.valid?
  end
  
  test "name should be present" do
    @repository.name = "   "
    assert_not @repository.valid?
  end
end
