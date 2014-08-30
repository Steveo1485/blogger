class EmailValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    if value.blank? == false and !(value =~ /.+@.+\..+/i)
      object.errors[attribute] << (options[:message] || "is not formatted properly")
    end
  end
end