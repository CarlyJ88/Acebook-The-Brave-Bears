require 'rails_helper'

RSpec.feature "User can delete post", type: :feature do
  let(:first_name) { 'Bob' }
  let(:last_name) { 'Geldof' }
  let(:email) { 'its.me@bobgeldof.com' }
  let(:password) { 'bob123' }

  scenario "User can delete their own post" do
    sign_up
    log_in
    visit('/posts')
    click_link('New post')
    fill_in('post[message]', with: "Hello I'm Bob Geldof!")
    click_button('Submit')
    expect(page).to have_content("Hello I'm Bob Geldof!")
    click_link('Delete')
    expect(page).to have_no_content("Hello I'm Bob Geldof!")
  end

  scenario "User cannot delete a post they didn't make" do
    sign_up
    log_in
    visit('/posts')
    click_link('New post')
    fill_in('post[message]', with: "Hello I'm Bob Geldof!")
    click_button('Submit')
    expect(page).to have_content("Hello I'm Bob Geldof!")

    first_name = 'Harry'
    last_name = 'Potter'
    email = 'harry-potter@broomsticksandwands.com'
    password = 'harry123'

    visit "/users/new"
    fill_in('user[first_name]', with: first_name)
    fill_in('user[last_name]', with: last_name)
    fill_in('user[email]', with: email)
    fill_in('user[password]', with: password)
    click_button('Signup')
    fill_in('session[email]', with: email)
    fill_in('session[password]', with: password)
    click_button('Log in')
    visit('/posts')
    expect(page).to have_no_link("Delete Post")
  end
end
