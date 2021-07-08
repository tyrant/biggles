class HomeController < ApplicationController

  # GET /
  # Just a placeholder. Returns the first page of all Tutors.
  def index
    render json: _serialized!(Tutor.all)
  end


  private


  def _serialized!(records)
    unless _instance_or_enumerable_of?(records, Tutor)
      raise "Oh come on, just a Tutor or an enumerable collection of them, please"
    end

    # The ResourceSerializer accepts either a *_Resource or an
    # array of them. Generate one or the other from our input
    # Tutor or collection.
    tutor_resources = if records.is_a?(Tutor)
      TutorResource.new(records, nil)
    else
      records.map{|r| TutorResource.new(r, nil) }
    end

    JSONAPI::ResourceSerializer.new(
        TutorResource,
        { include: ['tutor_availabilities', 
                    'tutor_availabilities.availabilities',
                    'subject_tutors',
                    'subject_tutors.subjects'] }
      ).serialize_to_hash(tutor_resources)
  end

end