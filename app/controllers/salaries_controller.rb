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
    @salaries = []
    12.times do |m|
      month_date = @date + m.month + 1.month - 1.day
      date_sql = Date.civil(month_date.year,month_date.month, month_date.day)
      salary = @employee.salaries.on_month(date_sql).order("salaries.year_month DESC").first
      month = (@date + m.month)
      if salary
        amount = salary.amount
        hours = salary.day_work_hours
        type = salary.sal_type

        tax_amount = salary.tax_amount
        tax_percent = salary.tax_percent
      else
        amount = "N/A"
        hours = "N/A"
        type = "N/A"
        tax_amount = "N/A"
        tax_percent = "N/A"
      end
      row = [month.strftime('%b'), amount, hours, month.strftime('%m'), type, tax_amount, tax_percent ]
      @salaries << row
    end

  end

  def edit_salary
    @employee = Employee.find(params[:employee_id])
    @year = params[:year]
    @month = params[:month]
    @date = Time.parse(params[:year]+'/'+params[:month]+'/01')
    @amount = params[:amount]
    @hours = params[:hours]
    @salary = Salary.new({:employee_id => @employee.id, :year_month => @date, :amount => @amount.to_i, :day_work_hours => @hours.to_i, :tax_amount => params[:tax_amount].to_i, :tax_percent => params[:tax_percent].to_i, :sal_type => params[:type].to_i })
    find_salary = Salary.find_by_object(@salary)
    p "find = ", find_salary
    if find_salary
      @salary = find_salary
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
        format.html { redirect_to(employee_salary_path(@salary.employee, :year => @salary.year_month.year), :notice => 'Salary was successfully created.') }
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
        format.html { redirect_to(employee_salary_path(@salary.employee, :year => @salary.year_month.year), :notice => 'Salary was successfully updated.') }
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

