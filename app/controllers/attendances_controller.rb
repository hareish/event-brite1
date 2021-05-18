class AttendancesController < ApplicationController

  def index
    @guests = User.joins(:attendances).where('attendances.event_id = ?', params[:event_id])
    puts @guests
    @event = Event.find(params[:event_id])
    @admin = User.find(@event.admin_id)
  end

  
  def show
  end

  
  def new
    create
  end

  
  def edit
  end

  def create
    @attendance = Attendance.new(user: current_user, stripe_customer_id: params[:token], event: Event.find(params[:event]))

    if @attendance.save
      flash[:success] = "You successfuly attended an event"
      redirect_to :controller => 'users', :action => 'show', id: current_user.id
    else
    
      flash.now[:danger] = "Erreur"
      render :action => 'new'
    end
  end

  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
       
      end
    end
  end

  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
     
    end
  end

  private
   
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    
    def attendance_params
      params.fetch(:attendance, {})
    end
end