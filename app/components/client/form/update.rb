module Client::Form
  class Update < Create

    property :avatar, prepopulator: :prepopulate_avatar! do
      property :image

      validates :image, file_size: {less_than: 2.megabytes},
                file_content_type: {allow: %w(image/jpeg image/png image/gif) }
    end

    private

    def prepopulate_avatar!(options)
      self.avatar = Avatar.new if self.avatar.blank?
    end
  end
end