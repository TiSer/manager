class MonthWorkingDaysController < ApplicationController
  # GET /month_working_days
  # GET /month_working_days.xml
  before_filter :authenticate_admin

  def index
    @month_working_days = MonthWorkingDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @month_working_days }
    end
  end

  def months_on_year_list
    if params[:year]
      @date = Time.parse(params[:year]+'/01/01')
    else
      @date = Time.parse(Time.now.year.to_s+'/01/01')
    end
    @months_on_year_list = []
    12.times do |m|
      month_date = @date + m.month
      date_sql = Date.civil(month_date.year,month_date.month, month_date.day)
      month_working_day = MonthWorkingDay.on_month(date_sql).first
      month = (@date + m.month)
      if month_working_day
        working_days = month_working_day.working_days
      else
        working_days = "N/A"
      end
      row = [month.strftime('%b'), month.strftime('%m'), working_days ]
      @months_on_year_list << row
    end
  end

  def edit_month_working_days
    @year = params[:year]
    @month = params[:month]
    #@date = Time.parse(params[:year]+'/'+params[:month]+'/01')
    @date = Date.civil(params[:year].to_i,params[:month].to_i, 1)
    p "dscsdcs = ", @date
    @month_working_day = MonthWorkingDay.new({:year_month => @date})
    p "MWD = ", @month_working_day
    find_month_working_day = MonthWorkingDay.find_by_object(@month_working_day)
    p "find = ", find_month_working_day
    if find_month_working_day
      @month_working_day = find_month_working_day
    end

  end

  # GET /month_working_days/1
  # GET /month_working_days/1.xml
  def show
    @month_working_day = MonthWorkingDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @month_working_day }
    end
  end

  # GET /month_working_days/new
  # GET /month_working_days/new.xml
  def new
    @month_working_day = MonthWorkingDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @month_working_day }
    end
  end

  # GET /month_working_days/1/edit
  def edit
    @month_working_day = MonthWorkingDay.find(params[:id])
  end

  # POST /month_working_days
  # POST /month_working_days.xml
  def create
    @month_working_day = MonthWorkingDay.new(params[:month_working_day])

    respond_to do |format|
      if @month_working_day.save
        format.html { redirect_to(year_working_days_list_path(:year => @month_working_day.year_month.year), :notice => 'Month working day was successfully created.') }
        format.xml  { render :xml => @month_working_day, :status => :created, :location => @month_working_day }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @month_working_day.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /month_working_days/1
  # PUT /month_working_days/1.xml
  def update
    @month_working_day = MonthWorkingDay.find(params[:id])

    respond_to do |format|
      if @month_working_day.update_attributes(params[:month_working_day])
        format.html { redirect_to(year_working_days_list_path(:year => @month_working_day.year_month.year), :notice => 'Month working day was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @month_working_day.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /month_working_days/1
  # DELETE /month_working_days/1.xml
  def destroy
    @month_working_day = MonthWorkingDay.find(params[:id])
    @month_working_day.destroy

    respond_to do |format|
      format.html { redirect_to(month_working_days_url) }
      format.xml  { head :ok }
    end
  end
end

