# frozen_string_literal: true

# module helper
module FilmsHelper
  # check image for presence, if nil returns default image
  def check_image(img)
    return ENV['DEFAULT_IMAGE'] if img.nil?

    if img.match?('https')
      img
    else
      ENV['DEFAULT_IMAGE']
    end
  end

  # displays rating if voted
  def check_rating(rating)
    if rating.empty?
      content_tag :p
    else
      content_tag :div, class: 'user-rating', score: @average_rating do
        content_tag :strong, 'My Cinema Rating: '
      end
    end
  end

  # returns time without seconds
  def show_time(time)
    new_time = time.to_s
    /^\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}/.match(new_time)
  end
end
