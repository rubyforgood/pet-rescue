class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # This method is used to translate the enum values for i18n.
  def human_enum_name(enum)
    enum_i18n_key = enum.to_s
    value = send(enum)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_i18n_key}.#{value}")
  end

  def self.human_enum_names(enum)
    enum_i18n_key = enum.to_s.singularize
    names = []
    send(enum).each_key do |key|
      names << I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_i18n_key}.#{key}")
    end

    names
  end
end
