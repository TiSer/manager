class ActivityCostsController < ApplicationController
  
  def costs
    @project = Project.find(params[:project_id])
    @activities = Activity.all
#    @activity = Activity.find(params[:id])
#    activity_cost = ActivityCost.where(:project_id => @project.id).first
#    activity_cos = ActivityCost.where(:project_id => self.project.id, :activity_id => booking.activity_id).last.amount
#    @activity_costs = ActivityCost.where(:project_id => @project.id)
    @activity_cost = ActivityCost.find(params[:id]) if params[:id]
    @activity_cost = ActivityCost.new if @activity_cost.nil?
#    @acts = []
    @acts = @activities.each do |activity|
    @activity_co = []
    @activity_co = ActivityCost.create(:project_id => @project.id, :activity_id => activity.id) if ActivityCost.where(:project_id => @project.id, :activity_id => activity.id) == []
    end

  end

  def create_act_cost
    @activity_cost = ActivityCost.new(params[:project_id][:activity_cost])

    respond_to do |format|
      if @activity_cost.save
        format.html { redirect_to(costs_path, :notice => 'Activity cost created.') }
        format.xml  { render :xml => @activity_costs, :status => :created, :location => @activity_cost }
      else
        format.html { render :action => "costs" }
        format.xml  { render :xml => @activity_cost.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_act_cost
    @activity_cost = ActivityCost.find(params[:id])

    respond_to do |format|
      if @activity_cost.update_attributes(params[:activity_cost])
        format.html { redirect_to(activity_costs_path(params[:project_id]), :notice => 'Activity cost was successfully updated.') }
        format.xml  { render :xml => @activity_costs, :status => :created, :location => @activity_cost }
      else
        format.html { render :action => "costs" }
        format.xml  { render :xml => @activity_cost.errors, :status => :unprocessable_entity }
      end
    end
  end

end
