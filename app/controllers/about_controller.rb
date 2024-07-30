class AboutController < ApplicationController
  def show
    @about = About.find_by(id: 1)
  end
end
