class BookingsController < ApplicationController
  # GET /bookings
  # GET /bookings.xml
  def index
    @bookings = Booking.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookings }
    end
  end

  # GET /bookings/1
  # GET /bookings/1.xml
  def show
    @booking = Booking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @booking }
    end
  end

  # GET /bookings/new
  # GET /bookings/new.xml
  def new
    @booking = Booking.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @booking }
    end
  end

  # GET /bookings/1/edit
  def edit
    @booking = Booking.find(params[:id])
  end

  # POST /bookings
  # POST /bookings.xml
  def create
    parse_end_date_for_bookings

    @booking = Booking.new(params[:booking])

    respond_to do |format|
      if @booking.save
        create_other_bookings

        format.html { redirect_to(staffing_path(@booking.project), :notice => 'Booking was successfully created.') }
        format.xml  { render :xml => @booking, :status => :created, :location => @booking }
        format.js {
                    @booking
                    @end_date
                    @bookings_array_for_ajax = make_bookings_array
                  }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
     end
    end
  end

  # PUT /bookings/1
  # PUT /bookings/1.xml
  def update
    @booking = Booking.find(params[:id])

    respond_to do |format|
      if @booking.update_attributes(params[:booking])
        format.html { redirect_to(@booking, :notice => 'Booking was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @booking.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.xml
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to(bookings_url) }
      format.xml  { head :ok }
    end
  end

#---------------------------------------------------------
  private
    def parse_end_date_for_bookings
       end_date = params[:booking][:end_date].split('.')
       @end_date  = Time.new(end_date[2],end_date[1],end_date[0])
       params[:booking].delete("end_date")
    end

    def create_other_bookings
       date = @booking.date
       while date <= @end_date do
         date += 1.day
         if !date.saturday? and !date.sunday?
           booking_item = Booking.new(params[:booking])
           booking_item.date = date
           booking_item.save
         end

       end
    end

    def make_bookings_array
      employee = @booking.employee
      date = @booking.date - 1.day
      bks_arr = []
       while date <= @end_date do
        date += 1.day
        project_bks = employee.bookings.where(:date => date, :project_id => @booking.project.id).sum("hours")
        all_bks = employee.bookings.where(:date => date).sum("hours")
        bks_arr << [project_bks, all_bks]
      end
      bks_arr
    end

end

