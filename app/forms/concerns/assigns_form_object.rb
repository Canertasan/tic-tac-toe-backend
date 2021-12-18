module AssignsFormObject
  extend ActiveSupport::Concern

  included do
    class_attribute :form_key, instance_writer: false
    class_attribute :form_object_params, instance_writer: false
    class_attribute :form_object_create_params, instance_writer: false

    self.form_key = nil
    self.form_object_params = nil
    self.form_object_create_params = nil
  end

  module ClassMethods
    def form_for(key, options)
      self.form_key = key
      self.form_object_params = params_from_options(options)
      self.form_object_create_params = create_params_from_options(options)
    end
  end

  def assign_object_attributes
    object.assign_attributes(permitted_form_object_parameters)
  end

  private

  def permitted_form_object_parameters
    if object.new_record?
      object_data.permit(self.class.form_object_params + self.class.form_object_create_params)
    else
      object_data.permit(self.class.form_object_params)
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
  end
end
