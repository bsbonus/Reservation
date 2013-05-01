module ReservationsControllerHelper
		

	def class_generator(reservation)
		if Recurrance.find_by_parent_id(reservation.recurrance_id) == nil 
			 @class = "normal" 
		else 
			 @class = "recurrance"  
		end
	end

	def find_recurrances(reservation)
		@reservation = reservation
		if @reservation.recurrance_id == nil
		  #if the reservation is the master reservation
	      recurrance_id = @reservation.id
	      @associated_recurrances = ( Reservation.where(:recurrance_id => recurrance_id) + 
	                              Reservation.where(id: recurrance_id) ).uniq.sort_by &:date
	    else 
	      #for a recurrance
	      recurrance_id = @reservation.recurrance_id
	      @associated_recurrances = (Reservation.where(:recurrance_id => recurrance_id) + 
	                                Reservation.where(:id => recurrance_id)).uniq.sort_by &:date
	    end
	    @id_list = ""
	    @associated_recurrances.each do |x|
	      @id_list += x.id.to_s + " "
	    end
	end 
	
end
