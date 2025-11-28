# PingGraph

## Setup for Personal Use

### Install Crystal

Windows:

1. Download Crystal from the official installer: [https://crystal-lang.org/install](https://crystal-lang.org/install)
2. Install and ensure the installer adds Crystal to PATH.

Linux (Debian/Ubuntu):

```
curl -fsSL https://crystal-lang.org/install.sh | sudo bash
sudo apt install crystal
```

macOS:

```
brew install crystal
```

### Run the program

1. Navigate to the folder:

```
cd pinggraph
```

2. Run directly without building:

```
crystal run src/pinggraph.cr -- --host google.com --interval 1
```

3. Or build a fast executable:

```
crystal build src/pinggraph.cr --release
```

Executable will be created in the same folder.

PingGraph is a minimal command-line latency visualizer written in Crystal.
It pings a target host at a fixed interval and renders the latency as a clean ASCII bar graph.

```
34ms     ||||||
52ms     ||||||||||||||
108ms    |||||||||||||||||||||||||||
timeout
44ms     |||||||||
```

## Features

* Cross-platform: Windows, Linux, macOS
* Automatic ping output parsing
* ASCII bar scaling based on latency
* Adjustable interval
* Optional fixed duration
* Optional single-ping mode

## Usage

```
pinggraph [options]
```

### Options

```
--host HOST          Host to ping (default: google.com)
--interval SECONDS   Seconds between pings (default: 1)
--duration SECONDS   Total runtime
--once               Run a single ping and exit
```

### Examples

Ping Google every second:

```
pinggraph --host google.com --interval 1
```

Run for 30 seconds:

```
pinggraph --duration 30
```

Single ping:

```
pinggraph --once
```
