# frozen_string_literal: true

# module helper
module FilmsHelper
  # check image for presence if nil returns default image
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
      content_tag :div, class: 'user-rating', score: rating.last.user_rating do
        content_tag :strong, 'User Rating:'
      end
    end
  end
end
