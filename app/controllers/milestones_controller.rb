class MilestonesController < ApplicationController

  before_filter :authenticate_admin

  def index
    @project = Project.find(params[:id])
    @milestones = Milestone.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @milestones }
    end
  end

  def show
    @milestone = Milestone.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @milestone }
    end
  end

  def milestone_bill
    @milestone = Milestone.find(params[:id])
    @bookings = @milestone.project.bookings
  end

  def new
    @project = Project.find(params[:id])
    @milestone = Milestone.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => add_milestone_path }
    end
  end

  # GET /milestones/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @milestone = Milestone.find(params[:id])
  end

  # POST /milestones
  # POST /milestones.xml
  def create
    @project = Project.find(params[:id])
    @milestone = Milestone.new(params[:milestone])

    respond_to do |format|
      if @milestone.save
        format.html { redirect_to(milestone_path(@milestone.id), :notice => 'Milestone was successfully created.') }
        format.xml  { render :xml => @milestone, :status => :created, :location => @milestone }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @milestone.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @milestone = Milestone.find(params[:id])

    respond_to do |format|
      if @milestone.update_attributes(params[:milestone])
        format.html { redirect_to(milestones_path(@milestone.project.id), :notice => 'Milestone was successfully updated.') }
        format.xml  { head :ok }
        format.js   { }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @milestone.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /milestones/1
  # DELETE /milestones/1.xml
  def destroy
    @project = Project.find(params[:id])
    @milestone = Milestone.find(params[:id])
    @milestone.destroy

    respond_to do |format|
      format.html { redirect_to(milestones_url) }
      format.xml  { head :ok }
    end
  end
end
