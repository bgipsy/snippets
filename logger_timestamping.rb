module LoggerTimestamping
  extend ActiveSupport::Concern
  included { alias_method_chain :add, :timestamps }

  def add_with_timestamps(severity, message = nil, progname = nil, &block)
    add_without_timestamps(severity, "#{formatted_now_timestamp} # #{message}", progname, &block)
  end

  def formatted_now_timestamp
    now = Time.now
    now.strftime("%m/%d %H:%M:%S.") + ("%03d" % (now.usec / 1000))
  end
end

ActiveSupport::BufferedLogger.send(:include, LoggerTimestamping)
