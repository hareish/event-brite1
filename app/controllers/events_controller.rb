class EventsController < ApplicationController



  def index
    @events = Event.all
  
  end

  
  def show
    @event = Event.find(params[:id])
    @admin = User.find(@event.admin_id)
    @nb_guests = Attendance.where(event_id: @event.id).count
  end


  def new
    @event = Event.new
  end


  def edit
    @event = Event.find(params[:id])
  end


  def create
    @event = Event.new(title: params[:title], 
      description: params[:description],
      location: params[:location],
      price: params[:price],
      start_date: params[:start_date],
      duration: params[:duration],
      admin_id: current_user.id)

    if @event.save 
        flash[:success] = "votre evenement a été bien créer"
        redirect_to :controller => 'events', :action => 'show', id: @event.id
    else
 
      flash.now[:danger] = "erreur avec création de compte"
      render :action => 'new'
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'votre évenement a été bien créer' }
  
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'votre événement a été bien supprimer' }

    end
  end

end