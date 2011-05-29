class EmployeesController < ApplicationController

  before_filter :prepare, :only => [:new, :edit]
  before_filter :authenticate_admin

  def index
    if params[:all]
       @employees = Employee.all      
    else
       @employees = Employee.active.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @employees }
      format.js   {  }
    end
  end

  def act
    @employee = Employee.all
    @employee. == true ? @employee.act = false : @employee.act = true #если чекбокс установлен снимаем галочку, иначе ставим
    if @employee.update_attributes
      flash[:notice] = "Bla."
      @employee = Employee.all #Получаем весь список tasks чтобы обновить шаблон 
    end
    respond_with(@employee)
  end


  # GET /employees/1
  # GET /employees/1.xml
  def show
    @employee = Employee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @employee }
    end
  end

  # GET /employees/new
  # GET /employees/new.xml
  def new
    @employee = Employee.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @employee }
    end
  end

  # GET /employees/1/edit
  def edit
    @employee = Employee.find(params[:id])
  end

  # POST /employees
  # POST /employees.xml
  def create
    @employee = Employee.new(params[:employee])

    respond_to do |format|
      if @employee.save
        format.html { redirect_to(employees_path, :notice => 'Employee was successfully created.') }
        format.xml  { render :xml => @employee, :status => :created, :location => @employee }
      else
        prepare
        format.html { render :action => "new" }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /employees/1
  # PUT /employees/1.xml
  def update
    params[:employee][:skill_ids] ||= []
    @employee = Employee.find(params[:id])

    respond_to do |format|
      if @employee.update_attributes(params[:employee])
        format.html { redirect_to(employees_path, :notice => 'Employee was successfully updated.') }
        format.xml  { head :ok }
      else
        prepare
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.xml
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to(employees_url) }
      format.xml  { head :ok }
    end
  end

  private #--------------------------------------------------------------------------------

  def prepare
    @departments = Department.dd
    @activities  = Activity.dd
  end    


end
