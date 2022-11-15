# frozen_string_literal: true

# module responsible by validate images
module AvatarValidator
  LOGOTYPE_SIZE = 150.kilobyte
  LOGOTYPE_CONTENT_TYPE = %w[image/jpeg image/png].freeze

  def self.included(klass)
    klass.validate :presence
    klass.validate :size
    klass.validate :content_type

    klass.has_one_attached :avatar

    klass.after_create :update_filename
  end

  def size
    return unless avatar.attached?

    errors.add(:avatar, I18n.t('messages.errors.image_size')) unless avatar.byte_size <= LOGOTYPE_SIZE
  end

  def content_type
    return unless avatar.attached?

    errors.add(:avatar, I18n.t('messages.errors.image_type')) if LOGOTYPE_CONTENT_TYPE.exclude?(avatar.content_type)
  end

  def presence
    errors.add(:avatar, I18n.t('messages.errors.required_field')) unless avatar.attached?
  end

  def update_filename
    filename = cnpj.gsub('.', '').gsub('/', '').gsub('-', '')

    avatar
      .blob
      .update(filename: "#{filename}.#{avatar.filename.extension}")
  end
end
