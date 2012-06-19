class ProfilesController < ApplicationController
  def edit
    @person = Person.find params[:person_id]
    if @person.profile.nil?
      profile = Profile.create
      @person.profile = profile
    end
    @profile = @person.profile
  end

  def update
  end
end
