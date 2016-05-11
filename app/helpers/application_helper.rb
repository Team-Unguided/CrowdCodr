module ApplicationHelper
    
  def greet(hour_of_clock)
    if hour_of_clock >= 6 && hour_of_clock <= 11
      "Good Morning"
    elsif hour_of_clock >= 12 && hour_of_clock <= 16
      "Good Afternoon"
    else
      "Good Evening"
    end
  end
    
end
