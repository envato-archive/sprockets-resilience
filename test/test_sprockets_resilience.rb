require "minitest/autorun"
require "minitest/pride"
require "sprockets/resilience"

$stringio = StringIO.new
Rails.logger = Logger.new($stringio)

class App < Rails::Application
  config.assets.enabled = true
  config.active_support.deprecation = :log
  config.assets.digest = true
  config.assets.compile = false

  initialize!
end

class TestSprocketsResilience < Minitest::Unit::TestCase
  def test_it_works
    assert_equal "/assets/foobar.png?not_precompiled", ActionController::Base.helpers.asset_path("foobar.png")
    $stringio.rewind
    assert_equal "asset_not_precompiled: foobar.png\n", $stringio.read
  end
end
