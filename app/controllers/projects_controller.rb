class ProjectsController < ApplicationController

  before_filter :authenticate_admin
  before_filter :prepare_departments, :only => [:new, :edit]
  before_filter :prepare_customers, :only => [:new, :edit]
  before_filter :prepare_activities, :only => [:staffing]

  def index
    @projects = Project.active.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  def milestone
    @project = Project.find(params[:id])
    @milestones = Milestone.all
  end

  def destroy_milestone
    @project = Project.find(params[:project_id])    
    @milestone = Milestone.find(params[:milestone_id])  

  end

  def destroy_milestone
    @project = Project.find(params[:project_id])
    @milestone = Milestone.find(params[:milestone_id])

    @milestone.destroy

    respond_to do |format|
      format.html { redirect_to milestone_path(@project.id) }
      format.xml  { head :ok }
    end
  end

  def costs
    @project = Project.find(params[:id])
    @activities = Activity.all
#    @activity_cost = ActivityCost.find(params[:id])

    @acts = @activities.each do |activity|
      @activity_co = []
      @activity_co = ActivityCost.create(:project_id => @project.id, :activity_id => activity.id) if ActivityCost.where(:project_id => @project.id, :activity_id => activity.id) == []
    end

  end


  def staffing
    @project = Project.find(params[:id])
    @participants = @project.employees.order('name')
    calendar_prev_next
    @booking_employees = make_bokings_hash_for(@participants)
  end

  def add_staff
    @project = Project.find(params[:id])
    @participants = @project.employees

    if params[:skill] and params[:skill][:id] != ""
      @active_employees = Employee.skilled(params[:skill][:id]).active.order('name')
      @current_dep_employees =  @active_employees.where(:department_id => @project.department.id).order('name')
    else
      @current_dep_employees = @project.department.employees.active.order('name')
      @active_employees = Employee.active.order('name')
    end

    @current_dep_employees -= @participants
    @others_employees = @active_employees - (@current_dep_employees + @participants)

    @others_employees = @others_employees

    @skills = Skill.dd

    calendar_prev_next

    @booking_current = make_bokings_hash_for(@current_dep_employees)
    @booking_others = make_bokings_hash_for(@others_employees)

  end

  def save_staff
    @project = Project.find(params[:id])
    if params[:project]
      params[:project][:employee_ids] ||= []
      @project.employee_ids = (@project.employee_ids << params[:project][:employee_ids]).flatten!
      if @project.save
         flash[:notice] = 'Staff was successfully added.'
         redirect_to staffing_path(@project.id, :day => params[:day],  :month => params[:month], :year => params[:year])
      end
    else
     flash[:notice] ='Select employees which you want to add, please.'
     redirect_to add_staff_path(@project.id, :day => params[:day],  :month => params[:month], :year => params[:year])
    end

  end

  def destroy_participant
    @project = Project.find(params[:project_id])

     employee = @project.employees.find(params[:employee_id])

     if employee
        delete_pariticipant_and_his_bookings(employee, @project)
        flash[:notice] ='Participant was successfully deleted.'
     end

     respond_to do |format|
      format.html { redirect_to(staffing_path(@project.id)) }
      format.js {@employee_id = employee.id }
     end
  end

  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end

  private #--------------------------------------------------------------------------------

  def prepare_departments
    @departments = Department.dd
  end

  def prepare_customers
    @customers = Customer.dd
  end

  def prepare_activities
    @activities = Activity.dd
  end

  def calendar_prev_next

    @current_date = Time.now

    if params[:month] and params[:year] and params[:day]
      @current_monday = Time.parse(params[:year]+'/'+params[:month]+'/'+params[:day])
    else
      @current_monday = @current_date.monday
    end

    if params[:offset]
      case params[:offset]
        when "prev_week"
          @current_monday -= 1.week
        when "prev_month"
          @current_monday -= 4.week
        when "next_month"
          @current_monday += 4.week
        when "next_week"
          @current_monday += 1.week
      end
    end
  end

  def make_bokings_hash_for(employees)
    booking_employees = {}
    employees.each do |employee|
       proj_bks = employee.bookings_from_monday_to_35th_day(@current_monday, @project.id)
       all_bks = employee.bookings_from_monday_to_35th_day(@current_monday)
       activity = employee.books_activity_on_interval(@current_monday, @current_monday.midnight + 35.day, @project.id)
       booking_employees.[]=(employee.id, {:project => proj_bks, :all => all_bks, :activity => activity})
    end
    booking_employees
  end

  def delete_pariticipant_and_his_bookings(employee,project)
    project.employees.delete(employee)
    current_date = Time.now
    current_date_sql = date_sql(current_date)
    Booking.date_greather_than(current_date_sql).where(:employee_id => employee.id, :project_id => project.id).destroy_all
  end

end
