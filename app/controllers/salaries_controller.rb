class SalariesController < ApplicationController
  # GET /salaries
  # GET /salaries.xml
  def index
    @salaries = Salary.order("salaries.year_month")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @salaries }
    end
  end

  def employee_salary
    @employee=Employee.find(params[:employee_id])
    if params[:year]
      @date = Time.parse(params[:year]+'/01/01')
    else
      @date = Time.parse(Time.now.year.to_s+'/01/01')
    end
 #   begin_date = @date
 #   end_date = (@date + 1.year)
    @salaries = []
    12.times do |m|
      month_date = @date + m.month + 1.month - 1.day
      date_sql = Date.civil(month_date.year,month_date.month, month_date.day)
      salary = @employee.salaries.on_month(date_sql).order("salaries.year_month DESC").first
      # p "sal = ", salary
      if salary
        row = [(@date + m.month).strftime('%b'), salary.amount, salary.day_work_hours]
      else
        row = [(@date + m.month).strftime('%b'), "N/A", "N/A"]
      end
      @salaries << row
    end

  end


  # GET /salaries/1
  # GET /salaries/1.xml
  def show
    @salary = Salary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @salary }
    end
  end

  # GET /salaries/new
  # GET /salaries/new.xml
  def new
    @salary = Salary.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @salary }
    end
  end

  # GET /salaries/1/edit
  def edit
    @salary = Salary.find(params[:id])
  end

  # POST /salaries
  # POST /salaries.xml
  def create
    @salary = Salary.new(params[:salary])

    respond_to do |format|
      if @salary.save
        format.html { redirect_to(@salary, :notice => 'Salary was successfully created.') }
        format.xml  { render :xml => @salary, :status => :created, :location => @salary }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @salary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /salaries/1
  # PUT /salaries/1.xml
  def update
    @salary = Salary.find(params[:id])

    respond_to do |format|
      if @salary.update_attributes(params[:salary])
        format.html { redirect_to(@salary, :notice => 'Salary was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @salary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /salaries/1
  # DELETE /salaries/1.xml
  def destroy
    @salary = Salary.find(params[:id])
    @salary.destroy

    respond_to do |format|
      format.html { redirect_to(salaries_url) }
      format.xml  { head :ok }
    end
  end
end

