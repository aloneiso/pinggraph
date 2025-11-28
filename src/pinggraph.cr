require "option_parser"

# Default values
host = "google.com"
interval = 1
duration = nil
run_once = false

OptionParser.parse do |parser|
  parser.banner = "Usage: pinggraph [options]"

  parser.on("--host HOST", "Host to ping") { |v| host = v }
  parser.on("--interval SECONDS", "Interval between pings") { |v| interval = v.to_i }
  parser.on("--duration SECONDS", "Total duration to run") { |v| duration = v.to_i }
  parser.on("--once", "Run only one ping") { run_once = true }
end

# Choose correct ping command based on OS
def ping_cmd(host : String) : String
  if Crystal::System.windows?
    "ping -n 1 #{host}"
  else
    "ping -c 1 #{host}"
  end
end

# Extract latency from ping output
def extract_latency(output : String) : Int32?
  # Windows pattern: time=34ms
  if match = output.match(/time[=<](\d+)ms/i)
    return match[1].to_i
  end

  # Linux/macOS pattern: time=34.5 ms
  if match = output.match(/time=(\d+\.?\d*)\s*ms/i)
    return match[1].to_f.round.to_i
  end

  nil
end

# Render bar graph
def print_bar(latency : Int32)
  bar_length = (latency / 5).clamp(1, 100)
  bars = "|" * bar_length
  puts "#{latency}ms ".ljust(8) + bars
end

def print_timeout
  puts "timeout"
end

start_time = Time.local

loop do
  if duration && (Time.local - start_time).total_seconds >= duration
    break
  end

  output = `#{ping_cmd(host)}` rescue ""

  if latency = extract_latency(output)
    print_bar(latency)
  else
    print_timeout
  end

  break if run_once
  sleep interval
end
