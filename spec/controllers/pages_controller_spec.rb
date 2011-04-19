require 'spec_helper'

describe PagesController do

  it "responds with success to GET :show, :id => 'home'" do
    get :show, :id => 'home'
    response.should be_success
    response.should render_template('pages/home')
  end

  it "responds with success to GET :show, :id => 'modules'" do
    get :show, :id => 'modules'
    response.should be_success
    response.should render_template('pages/modules')
  end

end
