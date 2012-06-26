class ProfilesController < ApplicationController
  before_filter :correct_user?
  def edit
    @page = create_standard_page
    @person = Person.find params[:person_id]
    if @person.profile.nil?
      profile = Profile.create
      @person.profile = profile
    end
    @profile = @person.profile
  end

  def update
    person = Person.find_by_id params[:person_id]
    profile = person.profile
    profile.update_attributes(params[:profile])
    redirect_to edit_person_profile_path(person.id)
  end
end
