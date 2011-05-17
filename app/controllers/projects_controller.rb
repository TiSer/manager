class ProjectsController < ApplicationController

  before_filter :prepare_departments, :only => [:new, :edit]
  before_filter :prepare_customers, :only => [:new, :edit]

  def index
    @projects = Project.active.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  def staffing
    @project = Project.find(params[:id])
    @participants = @project.employees.order('name')
  #  p Booking.where({ :created_at => (Time.now.midnight - 1.day)..Time.now.midnight})
 #   p "BOOKS = ", Booking.where("created_at >=  '#{Time.now.midnight}' AND created_at <= '#{Time.now.midnight+ 1.day}'")
    @current_date = Time.now
    @current_monday = @current_date.monday

    calendar_prev_next
=begin
    @booking_employees = {}
    @participants.each do |participant|
     #p "participant : ", participant.id
     this_bookings = participant.bookings_from_monday_to_35th_day(@current_monday)
     #date_arr = []
     #@this_bookings.each do |b|
     # date_arr << b.date if !@this_bookings.include?(b.date)
     #end
      #dates = @this_bookings.map(&:date)
      #arr = dates.uniq!
    # p "DATE ARR", arr
      if this_bookings
        d_arr = this_bookings.map(&:date)
        dates = d_arr
        bks_by_date = {}
        dates.each do |date|
          project_bks = this_bookings.where(:date => date, :project_id => @project.id).sum("hours")
          all_bks = this_bookings.where(:date => date).sum("hours")
          bks_by_date.[]=(date.strftime('%d.%m.%Y'), [project_bks, all_bks])
        end
        @booking_employees.[]=(participant.id, bks_by_date)
      end
    end
=end
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

    #Must_be_DRYed
    @current_date = Time.now
    @current_monday = @current_date.monday

    calendar_prev_next


  end

  def save_staff
    @project = Project.find(params[:id])
    if params[:project]
      params[:project][:employee_ids] ||= []
      @project.employee_ids = (@project.employee_ids << params[:project][:employee_ids]).flatten!
      if @project.save
         flash[:notice] = 'Staff was successfully added.'
         redirect_to staffing_path(@project.id)
      end
    else
     flash[:notice] ='Select employees which you want to add, please.'
     redirect_to add_staff_path(@project.id)
    end

  end

  def destroy_pariticipant
    @project = Project.find(params[:project_id])

     employee = @project.employees.find(params[:employee_id])

     if employee
        @project.employees.delete(employee)
        flash[:notice] ='Participant was successfully deleted.'
     end

  #  participant_id = params[:employee_id]
   # @project.employee_ids = @project.employee_ids.delete_if {|id| id == participant_id.to_i}
    #if @project.save
     #  flash[:notice] ='Participant was successfully deleted.'
    #end
       redirect_to staffing_path(@project.id)
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

  def calendar_prev_next
    if params[:month] and params[:year] and params[:day]
      @current_monday = Time.parse(params[:year]+'/'+params[:month]+'/'+params[:day])
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

end

