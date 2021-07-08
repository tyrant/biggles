class HomeController < ApplicationController

  # GET /
  # Just a placeholder. Returns the first page of all Tutors.
  def index
    render json: JSONAPI::ResourceSerializer.new(
        TutorResource,
        { include: ['tutor_availabilities',
                    'tutor_availabilities.availability',
                    'subject_tutors',
                    'subject_tutors.subject']
        }
      ).serialize_to_hash(
        Tutor.all.map{|t| TutorResource.new(t, nil) }
      )
  end

end