class ProfilesController < ApplicationController
  def edit
    person = Person.find params[:person_id]
    person.profile.nil? ? @profile = Profile.new : @profile = person.profile
  end

  def update
  end
end
