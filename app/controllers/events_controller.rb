class EventsController < ApplicationController
    def index 
     @event = Event.all
    end 


    def show 
        @event =Event.find(params[:id])
        @admin =User.find(@event.admin_id)
        @nb_guests = attendance.where(even_id: @event.id).count
    end 

    def new 
        @event =Event.new 
    end 

    def create 
        @event = Event.new (title:params [:Title], 
        description: params [:description], 
        prince: params[:price],
        start_date: params [:start_date],
        duration: params [:duration], 
        admin_id: current_user_id)

        if @event.save 
            flash [:success] = "tu as réussi a créer l'évenement"
            redirect_to :controller => 'event', :action => 'show', id: @event.id 
        else 
            flash.now [:danger] ="erruer avec la creation de votre compte"
        end 
    end 
    
    def update 
        respond_to do |format|
            if @event.update (event_params)
                format.html { redirect_to @event; notice : 'événement a été bien actualiser'}
                format.json { redirect_to : show, status: ok, location @event}
            else
                format.html { render :edit}
                format .json 


    def destroy 
        @event.destroy 
        respond_to do |format|
            format.html { redirect_to event_url, notice: 'évenement a été bien supprimer'}
            format.json { head: no_content}
        end 
    end 



end
