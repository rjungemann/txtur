require 'spec_helper'

describe 'Welcome', :js => true do

  it '' do
    visit root_path

    page.should have_content('Txtur')
  end

end

