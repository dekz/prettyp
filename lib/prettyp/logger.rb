require 'logger'
module Prettyp
  module Logger

    def self.logger
      @logger ||= ::Logger.new($stdout)
    end

    def logger
      Logger.logger
    end

  end
end
