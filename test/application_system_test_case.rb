require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  # change to headless to prevent the browser from popping up on the screen_size
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
end
