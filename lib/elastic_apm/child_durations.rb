# frozen_string_literal: true

module ElasticAPM
  # @api private
  module ChildDurations
    # @api private
    module Methods
      def child_durations
        @child_durations ||= Durations.new
      end

      def child_started
        child_durations.start
      end

      def child_stopped duration
        child_durations.stop duration
      end
    end

    # @api private
    class Durations
      def initialize
        @nesting_level = 0
        @duration = 0
        @mutex = Mutex.new
      end

      attr_reader :duration

      def start
        @mutex.synchronize do
          @nesting_level += 1
        end
      end

      def stop duration
        @mutex.synchronize do
          @nesting_level -= 1
          @duration += duration if @nesting_level == 0
        end
      end
    end
  end
end
