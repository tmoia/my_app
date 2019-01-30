require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test 'Invalid signup information' do
    get signup_path
    assert_no_difference 'User.count', 'An invalid user should not be created' do
      post signup_path, params: { user: { name: " ",
                                         email: "invalid@gmail",
                                         password:              "fuck",
                                         password_confirmation: "holacabron" } }
    end
    assert_template "users/new"
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
    assert_select 'form[action="/signup"]'
  end

  test "Valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { name:  "John",
                                          email: "testvalid@gmail.com",
                                          password:              "Goodpassword",
                                          password_confirmation: "Goodpassword"} }
    end
    follow_redirect!
    assert_template "users/show"
    assert_not flash.empty?
    end
end
