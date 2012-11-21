require 'spec_helper'

describe 'Welcome', :js => true do

  it 'shows a welcome page' do
    visit root_path

    page.should have_content('Txtur')

    pending
  end

  it 'shows a list of recent posts'

end

