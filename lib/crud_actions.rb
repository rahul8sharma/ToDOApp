module CRUDActions
  def index
    @entities = api_resource.all
  end

  def new
    @entity = api_resource.new
  end

  def create
    @entity = api_resource.create!(allowed_params)

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  def update
    @entity = api_resource.find(params[:id])
    @entity.update_attributes!(allowed_params)

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end

  def destroy
    @entity = api_resource.destroy(params[:id])

    respond_to do |f|
      f.html { redirect_to projects_url }
      f.js
    end
  end
end