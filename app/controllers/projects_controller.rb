class ProjectsController < ApplicationController

  before_filter :prepare_departments, :only => [:new, :edit]
  before_filter :prepare_customers, :only => [:new, :edit]

  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  def staffing
    @project = Project.find(params[:id])
    @participants = @project.employees
  end

  def add_staff
    @project = Project.find(params[:id])
    @participants = @project.employees



    @others_employees = []
    Employee.all.each do |employee|
      @others_employees << employee if !@participants.include?(employee) and\
                                        employee.is_active == true
    end

    if params[:skill]
      skill = Skill.find(params[:skill][:id])
      @finded_employees = []
      @others_employees.each do |oe|
        @finded_employees << oe if oe.skills.include?(skill)
      end
      @others_employees = @others_employees.delete_if { |o| @finded_employees.include?(o) }
    end

=begin
    @others_ids_str = @participants.map(&:id).join(',')

    if params[:skill]
      skill = Skill.find(params[:skill][:id])
       @finded_employees = skill.employee.where("id NOT IN(\"#{@others_ids_str}\") AND is_active = true")
      @others_ids_str += ',' if @others_ids_str != ''
      @others_ids_str += @finded_employees.map(&:id).join(',')
    end

    @others_employees = Employee.where("id NOT IN(\"#{@others_ids_str}\") AND is_active = true")
=end

    @skills = []
    @skills = [[skill.name, skill.id]] if skill
    Skill.all.each do |skill|
      @skills << [skill.name, skill.id]
    end
    @skills.uniq!

  end

  def save_staff
    @project = Project.find(params[:id])
    if params[:project]
      params[:project][:employee_ids] ||= []
      @project.employee_ids = (@project.employee_ids << params[:project]\
      [:employee_ids]).flatten!
      if @project.save
         flash[:notice] = 'Staff was successfully added.'
      end
    else
     flash[:notice] ='Select employees which you want to add, please.'
    end
    redirect_to add_staff_path(@project.id)
  end

  def destroy_pariticipant
    @project = Project.find(params[:project_id])
    participant_id = params[:employee_id]
    @project.employee_ids = @project.employee_ids.delete_if {|id| id == participant_id.to_i}
    if @project.save
       flash[:notice] ='Participant was successfully deleted.'
    end
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
    @departments = []
    Department.all.each do |dep|
      @departments << [dep.name, dep.id] if dep.is_active
    end
  end

  def prepare_customers
    @customers = []
    Customer.all.each do |cus|
      @customers << [cus.name, cus.id] if cus.is_active
    end
  end

end

