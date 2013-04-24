class ReservationsController < ApplicationController

  before_filter :authorize
  include ReservationsControllerHelper

  def index
    @reservations = Reservation.all
    @reserv = Reservation.where(:date => Date.today)
    @recurrances = Recurrance.all
    @exclusions = Exclusion.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def create
    @reservation = Reservation.new(params[:reservation])
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservations_url, notice: 'Reservation was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def new
  	@reservation = Reservation.new
    respond_to do |format|
      format.html
    end 
  end

  def edit

    @reservation = Reservation.find(params[:id])
    find_recurrances(@reservation)

    respond_to do |format|
      format.html
    end  
  end

  def update
    @reservation = Reservation.find(params[:id])
    find_recurrances(@reservation)
    @ids = params[:reservation_ids][0].split(" ")
    @reservations = Reservation.find(@ids)
    @reservations.each do |reservation|
      reservation.update_attributes!(params[:reservation].reject { |k,v| v == @reservation.date} )
    end

      #@ids.each do |id|
      #  @reserv = Reservation.find(id)
       # @reserv.update_attribute(:room, params[:reservation][:room])
        #@reserv.save!
      #end
    respond_to do |format|
        format.html { redirect_to reservations_url }
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    find_recurrances(@reservation)
 
    respond_to do |format|
      format.html
      format.js
    end    
  end

  def delete_multiple
    
    if params[:reservation_ids] #should be adapted to fit any size of ID, eg. id of 100,000
      params[:reservation_ids] = params[:reservation_ids][0].split(" ") 
    else
       redirect_to reservations_url   
    end
    @reservations = Reservation.find(params[:reservation_ids])
    @recurrance_id = @reservations.first.recurrance_id
    @parent_id = @recurrance_id
    @recurrance = Recurrance.find_by_parent_id(@parent_id)
    @exclusions = Exclusion.where(recurrance_id: @parent_id)
    if @exclusions.count > 0 
      if @exclusions.count == @recurrance.duration
        @recurrance.destroy
        @exclusions.each do |x|
          x.destroy
        end
      end
    end

    @reservations.each do |x|
      x.destroy
    end
    respond_to do |format|
      format.html { redirect_to reservations_url }
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url }
    end
  end

  private
  def authorize
    if session[:official] != true
      render 'shared/signin'
    end 
  end

end
