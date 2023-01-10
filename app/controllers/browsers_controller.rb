class BrowsersController < ApplicationController
    def technology
        @technologies = Technology.all
    end
    
    def category
        @technology = Technology.find_by_name(params[:technology])
        @hierarchies = Hierarchy.where(:technology_id => @technology.id)
        @categories = Category.where(:id => @hierarchies.map {|hierarchy| hierarchy.id})
    end
    
    def hierarchy
        @technology = Technology.find_by_name(params[:technology])
        @category = Category.find_by_name(params[:category])
        @hierarchy = Hierarchy.find_by(technology_id: @technology.id, category_id: @category.id)
        @repositories = Repository.where(:hierarchy_id => @hierarchy.id)
    end
    
    def repository
        @technology = Technology.find_by_name(params[:technology])
        @category = Category.find_by_name(params[:category])
        @hierarchy = Hierarchy.find_by(technology_id: @technology.id, category_id: @category.id)
        @repository = Repository.find_by(hierarchy_id: @hierarchy.id, owner: params[:owner], name: params[:name])
    end
end
