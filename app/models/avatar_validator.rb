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
    klass.after_update :update_filename

    klass.before_validation(on: :create) { add_default_avatar }
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

  def add_default_avatar
    return if avatar.attached?
    return if is_a?(Company)

    avatar
      .attach(io: avatar_default_file, filename: Avatar::AVATAR_DEFAULT_NAME, content_type: 'image/png')
  end

  def update_filename
    avatar_data = avatar.blob

    return if avatar_data.filename.to_s == Avatar::AVATAR_DEFAULT_NAME

    avatar_data.update(filename: "#{afro_id}.#{avatar.filename.extension}")
  end

  private

  def avatar_default_file
    File.open(Rails.root.join('app', 'assets', 'images', Avatar::AVATAR_DEFAULT_NAME))
  end
end
