module ApplicationHelper

	def user_sign_in
		greeting = session[:name]
		if session[:official] != true
		  raw("#{link_to 'Sign-in', '/auth/admin' }")
		else
		  raw("Welcome #{greeting} #{link_to 'Logout', '/sessions/destroy'}")
		end 
	end

	def day_filtered (day, comparison_day)
 		@day_filtered = []

 		@week_reservs.each do |day| 
		 	if day.date.strftime("%A") == comparison_day
		 		@day_filtered << day 
			end
		end
		return @day_filtered
  end

  def insert_dates
    headers.each do |day|
      content_tag(:td, :id => day) do
        content_tag(:div, @date_range[0].strftime("%B %e") )
      end 
    end
  end

	def date_builder(date)
		first = date
		date_range = []
		i = 0
		while i < 7
			date_range << first + i.days
			i = i + 1
		end
		return date_range
	end

	def calendar_header
		if params[:date] == nil 
	 	@date = Date.today
 	else 
		@date = Date.parse(params[:date]).to_date
 	end
 	  return @date 
	end

	def week_limit
    if params[:limit] == nil 
	 	  @limit = 1
    elsif params[:limit].to_i < 0
      @limit = 0
 	  else 
		  @limit = params[:limit].to_i
	  end
	  return @limit
	end


	def week_filtered(start_day)
		@week_reservs = []
		start_day = start_day
	  first = start_day.beginning_of_week(:sunday)
	  last = start_day.end_of_week(:sunday)
	  @date_range = date_builder(first)
    @recurrances = recurrances_in_week(start_day)
    if @recurrances.length > 1
      @filtered_recurrances = @recurrances.reject{ |x| x.date > last }.reject{ |x| x.date < first }
      @filtered_recurrances.each do |recurrance|
        if Exclusion.where(recurrance_id: recurrance['recurrance_id'], reserv_exclusion: recurrance['date']).count == 0  
          Reservation.create(date: recurrance['date'], room: recurrance['room'], time_in: recurrance['time_in'],
                             time_out: recurrance['time_out'], recurrance_id: recurrance['recurrance_id'] )
          Exclusion.find_or_create_by_recurrance_id_and_reserv_exclusion(
                            recurrance['recurrance_id'], 
                            recurrance['date'] )
        end
      end
    end
    @week_reservs = Reservation.where(:date => first..last)
		return @week_reservs, @date_range #, @filtered_recurrances 
	end


  def recurrances_in_week(start_day)
    start_day = start_day
    all_unfiltered_recurrances = []
      Recurrance.find_each do |recur|
        if recur.duration == nil 
          recur.duration = 0
        end
        if (recur.start_date + (7 * recur.duration).days > start_day)
          unfiltered_recurrances = generate_recurrances(recur, start_day)
          unfiltered_recurrances.each do |x|
            all_unfiltered_recurrances << x
          end
        end
      end
    return all_unfiltered_recurrances
  end

  def generate_recurrances(recurrance, start_day)
    unfiltered_recurrances = []
    i = 1
    while i <= (recurrance.duration + 1) do 
      date = recurrance.start_date + (7 * i).days
        unfiltered_recurrances << Reservation.new(id: recurrance.id, date: date, room: recurrance.room, 
                                                time_in: recurrance.time_in, time_out: recurrance.time_out,
                                                recur: recurrance.recur, recurrance_id: recurrance.parent_id)        
      i = i + 1
    end
    return unfiltered_recurrances
  end


	def render_week(date)
    content_tag(:tr) do 
      render 'week', collection: week_filtered(date)
    end
	end

  def render_weeks(date, limit=0)
    @date = date
    limit =  limit
    i = 1
    all_weeks = render_week(@date)
    while i <= limit
      all_weeks = all_weeks + render_week(@date + (i * 7).days)
      i += 1
    end
    return all_weeks
  end

  def format_month(date)
    date.strftime("%B %Y")
  end

	def format_date(date)
		date.strftime("%B %e")
	end

  def format_time(time_in)
    time_in.strftime("%l:%M %p")
  end

  def create_cell(i, date_range, type)
    headers = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    content_tag(:td, :class => type ) do
      content_tag(:div) do
        concat format_date @date_range[i]
        concat render 'day', collection: day_filtered(headers[i], headers[i])
      end
    end
  end

  def create_day(day_reservations)
    room = day_reservations.room 
    time_in = format_time day_reservations.time_in 
    time_out = format_time day_reservations.time_out 
    reservation_details = room + " " + time_in + " " + time_out + day_reservations.createdby.to_s 
    link_to reservation_details, edit_reservation_path(day_reservations, :class => class_generator(day_reservations) ) ,
      :id => day_reservations.id, :class => class_generator(day_reservations) 
  end

end
