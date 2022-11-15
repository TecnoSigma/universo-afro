# frozen_string_literal: true

# module responsible by validate images
module AvatarValidator
  LOGOTYPE_SIZE = 150.kilobyte
  LOGOTYPE_CONTENT_TYPE = %w(image/jpeg image/png)

  def self.included(klass)
    klass.validate :presence
    klass.validate :size
    klass.validate :content_type

    klass.has_one_attached :avatar

    klass.after_create :update_filename
  end

  def size
    return unless self.avatar.attached?

    unless self.avatar.byte_size <= LOGOTYPE_SIZE
      errors.add(:avatar, I18n.t('messages.errors.image_size'))
    end
  end

  def content_type
    return unless self.avatar.attached?

    if LOGOTYPE_CONTENT_TYPE.exclude?(self.avatar.content_type)
      errors.add(:avatar, I18n.t('messages.errors.image_type'))
    end
  end

  def presence
    unless self.avatar.attached?
      errors.add(:avatar, I18n.t('messages.errors.required_field'))
    end
  end

  def update_filename
    filename = self.cnpj.gsub('.', '').gsub('/', '').gsub('-', '')

    self
      .avatar
      .blob
      .update(filename: "#{filename}.#{self.avatar.filename.extension}")
  end
end
