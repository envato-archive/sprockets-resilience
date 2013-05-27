require "rails/all"

class Sprockets::Resilience < Rails::Railtie
  initializer "sprockets.resilience", :group => :all, :after => "sprockets.environment" do |env|
    # this monkey patch stops rails from killing the entire site when some asset
    # slips through the cracks and doesn't get precompiled.

    ::Sprockets::Helpers::RailsHelper::AssetPaths.class_eval do
      def digest_for(logical_path)
        if digest_assets && asset_digests && (digest = asset_digests[logical_path])
          return digest
        end

        if compile_assets
          if digest_assets && asset = asset_environment[logical_path]
            return asset.digest_path
          end
          return logical_path
        else
          # this was the original code:
          # raise AssetNotPrecompiledError.new("#{logical_path} isn't precompiled")

          # monkey patch right here:
          Rails.logger.warn "asset_not_precompiled: #{logical_path}"
          "#{logical_path}?not_precompiled"
        end
      end
    end
  end
end
