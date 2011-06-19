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
    @begin_date = @booking.date

    if @booking.hours <= 0
      Booking.destroy_bookings_by_object(@booking,@end_date)
    else
      create_or_update_other_bookings
    end

    respond_to do |format|
        format.js {
                    @booking
                    @end_date
                    @bookings_hash_for_ajax = make_bookings_hash
                  }
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
       @end_date = Date.parse(end_date[2]+'/'+end_date[1]+'/'+end_date[0])
       params[:booking].delete("end_date")
    end

    def create_or_update_other_bookings
       @booking.update_or_this do
         @booking.save
       end

       date = @booking.date
       booking_dup = @booking

       while date <= (@end_date - 1.days) do
         date += 1.day
         booking_dup.date = date
         booking_dup.update_or_this do
           if !weekend?(date)
             booking_item = Booking.new(params[:booking])
             booking_item.date = date
             booking_item.save
           end
         end
       end
    end

    def make_bookings_hash
      employee = @booking.employee
      project_bks = employee.bookings_on_interval(@begin_date, @end_date, project_id = @booking.project.id)
      all_bks = employee.bookings_on_interval(@begin_date, @end_date)
      activity = employee.books_activity_on_interval(@begin_date, @end_date, @booking.project.id)
      hash = {:project => project_bks, :all => all_bks, :activity => activity}
    end
end

