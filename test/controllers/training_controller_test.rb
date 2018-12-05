require 'test_helper'

class TrainingControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get training_show_url
    assert_response :success
  end

end
