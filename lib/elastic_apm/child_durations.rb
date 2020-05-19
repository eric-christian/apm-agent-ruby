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

      def child_stopped
        child_durations.stop
      end
    end

    # @api private
    class Durations
      def initialize
        @started_childs = 0
        @start = 0
        @duration = 0
        @mutex = Mutex.new
      end

      attr_reader :duration

      def start
        @mutex.synchronize do
          @start = Util.micros if @started_childs == 0
          @started_childs += 1
        end
      end

      def stop
        @mutex.synchronize do
          @started_childs -= 1
          @duration += (Util.micros - @start) if @started_childs == 0
        end
      end
    end
  end
end
