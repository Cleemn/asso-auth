class HomeController < ApplicationController
  def index
    if current_user
      @my_association = Association.find_by(rna_id: current_user.rna)
    end
  end
end
