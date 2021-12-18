class Service
  class ServiceError < StandardError; end
  class ServiceFailedError < ActiveRecord::Rollback; end

  include Virtus.model

  CANNOT_BE_EMPTY = I18n.t('errors.messages.empty')
  NOT_A_NUMBER    = I18n.t('errors.messages.not_a_number')
  NOT_A_DATE      = I18n.t('errors.messages.not_a_date')

  attr_accessor :status, :errors, :error_desc, :result, :before_actions

  def self.call(*args)
    service_object = new(*args)
    apply_before_actions(service_object)
    if service_object.valid?
      service_object.result = service_object.call
      service_object.status = :success unless service_object.status == :failed
    end
    service_object
  end

  def initialize(*args)
    super
    self.status = :not_run
    self.errors = []
    self.before_actions = []
  end

  def valid?
    do_default_validation
    validate if self.respond_to?(:validate)
    status != :failed
  end

  def succeeded?
    status == :success
  end

  def failed?
    status != :success
  end

  def self.apply_before_actions(service_object)
    return unless @before_actions.present?

    @before_actions.each do |method, block|
      block.present? ? service_object.send(method, &block) : service_object.send(method)
    end
  end

  def self.before_action(method, &block)
    @before_actions ||= []
    @before_actions << (block_given? ? [method, block] : method)
  end

  protected

  # sets error_desc, copies the object errors (if present?) and raises a rollback error
  def fail_with_error(error_desc, object = nil)
    if object.nil?
      add_error(error_desc)
    else
      add_errors(error_desc, object)
    end
    raise ServiceFailedError.new, error_desc, errors
  end

  # adds a single error to the errors collection
  def add_error(error, options = {})
    self.status = :failed
    self.errors << I18n.t("#{i18n_key}.errors.#{error}", options)
  end

  # sets the error description and copies the object errors. unlike fail_with_error doesn't raise an error
  def add_errors(error_desc, object)
    self.status = :failed
    self.error_desc = I18n.t("#{i18n_key}.errors.#{error_desc}")
    if object.respond_to?(:errors)
      self.errors += object.errors.respond_to?(:full_messages) ? object.errors.full_messages : object.errors
    end
  end

  private

  def i18n_key
    self.class.name.underscore.tr('/', '.')
  end

  def do_default_validation
    self.class.attribute_set.each do |attribute|
      required = attribute_required?(attribute)
      type_check = do_type_check?(attribute)
      if required || type_check
        value = send(attribute.name)
        check_required_value(value, attribute) if required
        check_attribute_type(value, attribute) if value.present? && type_check
      end
    end
  end

  # for string values requirement check fails if the value is blank?
  # otherwise it checks only whether the value is nil
  def attribute_required?(attribute)
    attribute.options[:required] == true || (attribute.options[:required].is_a?(Symbol) && send(attribute.options[:required]) == true)
  end

  def check_required_value(value, attribute)
    add_attribute_error(attribute, CANNOT_BE_EMPTY) if value.nil? || (value.is_a?(String) && value.blank?)
  end

  def do_type_check?(attribute)
    attribute.type == BigDecimal || attribute.type == Date || attribute.type == DateTime
  end

  def check_attribute_type(value, attribute)
    add_attribute_error(attribute, NOT_A_NUMBER) if attribute.type == BigDecimal && (!value.is_a?(BigDecimal) || value.nan?)
    add_attribute_error(attribute, NOT_A_DATE)  if attribute.type == Date && !value.is_a?(Date)
  end

  def add_attribute_error(attribute, message)
    attr_name = I18n.t("#{i18n_key}.attributes.#{attribute.name}")
    self.errors << "#{attr_name} #{message}"
    self.status = :failed
  end
end
