# # # RELATION PARAMS:

# # GENERAL:
# relation (required): relation name for the main object
# params (required):   accepted parameters for the relation object from sent params
# types: allowed types for sent relations

# # HAS MANY AND HAS ONE:
# dependent:
#  - true:            relation cannot live without the main object, so will be destroyed after unassigning
#  - false (default): relation can live without the main object

# # BELONGS TO:
# (attributes of belongs_to records can be modified only when creating)
# creating_values:    default values for creating a new belongs_to record
# related_attributes: shared attributes between the main object and relation. Used for creating.

require 'tic_tac_toe_errors'

class FormObject
  include Virtus.model
  include AssignsFormObject

  attribute :object
  attribute :object_type
  attribute :object_data

  def initialize(object, params)
    raise 'form_for not given' unless form_key

    bad_request!('parameter -> data must be a JSON Object') unless params[:data].is_a?(ActionController::Parameters)

    self.object             = object
    self.object_type        = params.require(:data).require(:type)
    self.object_data        = assign_object_data_attributes(params.require(:data)[:attributes])

    bad_request!("data->type must be: #{form_key.to_s.pluralize}") if object_type != form_key.to_s.pluralize

    assign_object_attributes
  end

  def self.params_from_options(options)
    raise 'invalid options hash' if options.nil? || !options.is_a?(Hash)
    raise 'params not given or not an array' if !options.key?(:params) || !options[:params].is_a?(Array)

    options[:params]
  end

  def self.create_params_from_options(options)
    raise 'invalid options hash' if options.nil? || !options.is_a?(Hash)
    raise 'create_params is not an array' if options.key?(:create_params) && !options[:create_params].is_a?(Array)

    Array(options[:create_params])
  end

  private

  def bad_request!(message = nil)
    raise TicTacToeErrors::BadRequest, message
  end

  def assign_object_data_attributes(attributes)
    return ActionController::Parameters.new if attributes.nil? || attributes.empty?

    attributes
  end
end
