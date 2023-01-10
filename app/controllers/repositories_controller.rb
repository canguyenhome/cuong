class RepositoriesController < ApplicationController
  before_action :set_repository, only: %i[ show edit update destroy ]
  
  Graphql = Cuong::Client.parse <<-'GRAPHQL'
    query($owner: String!, $name: String!)  { 
      repository(owner: $owner, name: $name) {
        stargazerCount,
        forkCount,
        defaultBranchRef{
            target{
                ... on Commit{
                    history(first:1){
                        edges{
                            node{
                                ... on Commit{
                                    committedDate
                                }
                            }
                        }
                    }
                }
            }
        }
      }
    }
  GRAPHQL

  
  def new
  end

  def create
    @repo_owner = params[:repository][:repository].split("/")[0]
    @repo_name = params[:repository][:repository].split("/")[1]
    
    data = query Graphql, owner: @repo_owner, name: @repo_name
    
    if not data.repository
      respond_to do |format|
        format.html { redirect_to new_repository_path, notice: "Createion failed. Failed to query github repo data"}
      end
      return
    end
    
    @technology = Technology.find_or_create_by(name: params[:repository][:technology])
    @category = Category.find_or_create_by(name: params[:repository][:category])
    @hierarchy = Hierarchy.find_or_create_by(technology_id: @technology.id, category_id: @category.id)
    @repository = @hierarchy.repositories.build(
      name: @repo_name,
      owner: @repo_owner,
      stargazer_count: data.repository.stargazerCount,
      fork_count: data.repository.forkCount,
      since_last_commit: (Time.now - Time.parse(data.repository.defaultBranchRef.target.history.edges.first.node.committedDate))/(24*60*60),
    )

    respond_to do |format|
      if @repository.save
        format.html { redirect_to browser_repository_path(@technology.name, @category.name, @repo_owner, @repo_name), notice: "Github repo was successfully created." }
        format.json { render :show, status: :created, location: @repository }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repository
      @repository = Repository.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def repository_params
      params.require(:repository).permit(:name, :owner, :hierarchy_id)
    end
end
