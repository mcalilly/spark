require "test_helper"

Capybara.disable_animation = true
Capybara.default_max_wait_time = 10

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  # Generic helper for finding an iframe
  def find_frame(selector, &block)
   using_wait_time(25) do
     frame = find(selector)
     within_frame(frame) do
       block.call
     end
   end
  end
end
