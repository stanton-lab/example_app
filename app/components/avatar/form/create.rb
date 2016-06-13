module Avatar::Form
  class Create < ::Reform::Form

      property :image

      validates :image, file_size: {less_than: 2.megabytes},
                file_content_type: {allow: %w(image/jpeg image/png image/gif) }

  end
end