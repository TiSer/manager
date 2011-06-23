class ActivityCostsController < ApplicationController
  

  def cost_edit
    @cost = ActivityCost.find(params[:id])
    @project = @cost.project
  end

  def update_act_cost
    @activity_cost = ActivityCost.find(params[:id])

    respond_to do |format|
      if @activity_cost.update_attributes(params[:activity_cost])
        format.html { redirect_to(activity_costs_path(@activity_cost.project.id), :notice => 'Activity cost was successfully updated.') }
        format.xml  { render :xml => @activity_costs, :status => :created, :location => @activity_cost }
      else
        format.html { render :action => "costs" }
        format.xml  { render :xml => @activity_cost.errors, :status => :unprocessable_entity }
      end
    end
  end

end
