# frozen_string_literal: true

module DataCleanup
  module Rules
    module Org
      class FixBlankLanguage < Rules::Base

        DEFAULT_LANGUAGE = Language.find_by(abbreviation: "en_GB")

        def description
          "Fix blank language on Org"
        end

        def call
          ids = ::Org.where(language: [nil, ""]).pluck(:id)
          log("Setting language to #{DEFAULT_LANGUAGE} for Orgs: #{ids}")
          ::Org.where(id: ids).update_all(language_id: DEFAULT_LANGUAGE.id)
        end
      end
    end
  end
end
