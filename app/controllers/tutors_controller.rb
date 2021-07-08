class TutorsController < ApplicationController

  before_action :authenticate_user!
  before_action :validate_params!

  def search
    render json: _serialized!(Tutor.search(tutor_params))
  end

  def update
  end

  private

  def tutor_params
    params.permit!.to_h
  end


  def validate_params!
    tutor_search_api_schema = {
      type: 'object',
      required: [],
      properties: {
        availabilities: { 
          type: 'array',
          items: {
            type: "integer",
            minimum: 0,
          }
        },
        postcode: { 
          type: 'string',
          pattern: "^[0-9]*$", # A string of zero-or-more digits
        },
        distance: { 
          type: 'integer',
          minimum: 0,
        },
        rate: {
          type: 'object',
          properties: {
            low: { 
              type: 'number',
              minimum: 0,
            },
            high: { 
              type: 'number',
              minimum: 0,
            },
          },
          additionalProperties: false,
        },
        subjects: {
          type: 'array',
          items: {
            type: 'integer',
            minimum: 0,
          }
        },
        languages: {
          type: 'array',
          items: {
            type: 'integer',
            minimum: 0,
          }
        },
        page_number: { 
          type: 'integer',
          minimum: 0,
        },
        page_size: { 
          type: 'integer',
          minimum: 0,
        },
      },
    }

    errors = JSON::Validator.fully_validate(tutor_search_api_schema, tutor_params)

    # SPECIAL CASES: I don't think it's possible to do json-schema validation where values depend on other values. Do them manually instead. 

    # Is rate[low] greater than rate[high]?
    if errors.length == 0 && tutor_params.key?(:rate)
      if tutor_params[:rate].key?(:low) && tutor_params[:rate].key?(:high)
        if tutor_params[:rate][:low].is_a?(Numeric) && tutor_params[:rate][:high].is_a?(Numeric)
          if tutor_params[:rate][:low] > tutor_params[:rate][:high]
            errors << "The property '#/rate/high' can't be less than '#/rate/low', now can it, dahlink"
          end
        end 
      end
    end

    if errors.length > 0
      render json: {
        status: "A cheapass like you can't afford me, can you, #{ Faker.any_character }, not with JSON that invalid",
        error: errors 
      }.to_json, status: 402
    end
  end


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