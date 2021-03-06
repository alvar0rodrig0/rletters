# frozen_string_literal: true

require 'minitest/assertions'

module Minitest
  module Assertions
    def assert_valid_download(mime, response)
      assert response.successful?
      assert response.content_type = mime
      refute response.body.empty?
    end
  end
end
